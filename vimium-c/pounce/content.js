(() => {
  const LABELS = "asdfghjklqwertyuiopzxcvbnm";
  const MAX_MATCHES = 300;
  const MAX_GAP = 2;
  const SKIP_TAGS = new Set(["SCRIPT", "STYLE", "NOSCRIPT", "TEXTAREA", "SELECT", "OPTION"]);
  const isTop = window === window.top;

  // Per-frame session (every frame): text nodes, highlights, labels, saved selection.
  let fs = null;
  // Prompt (top frame only): input, label -> match map.
  let ui = null;

  const pageStyle = `
    ::highlight(pounce-dim) { color: rgba(128, 128, 128, 0.55); }
    ::highlight(pounce-match) { color: #000; background-color: #ffd54f; }
  `;

  const shadowStyle = `
    .label {
      position: fixed; z-index: 1;
      font: bold 11px/1.25 monospace; padding: 0 2px; border-radius: 2px;
      color: #fff; background: #e53935; box-shadow: 0 1px 2px rgba(0,0,0,.4);
    }
    .label.best { background: #2e7d32; }
    input {
      position: fixed; left: 50%; bottom: 24px; transform: translateX(-50%);
      width: 280px; padding: 6px 10px; pointer-events: auto;
      font: 14px monospace; color: #eee; background: #222; caret-color: #ffd54f;
      border: 1px solid #555; border-radius: 4px; outline: none;
      box-shadow: 0 2px 10px rgba(0,0,0,.5);
    }
  `;

  const send = (msg) => chrome.runtime.sendMessage(msg);
  const broadcast = (msg, skip = []) =>
    send({ type: "broadcast", msg, skip }).then((rs) => (rs || []).filter(Boolean));
  const sendTo = (frameId, msg) => send({ type: "send", frameId, msg });

  function makeOverlay(html) {
    const host = document.createElement("div");
    host.style.cssText = "all: initial; position: fixed; inset: 0; z-index: 2147483647; pointer-events: none;";
    const root = host.attachShadow({ mode: "open" });
    root.innerHTML = `<style>${shadowStyle}</style>${html}`;
    document.documentElement.append(host);
    return { host, root };
  }

  // Part of this frame's viewport that is visible in the top-level viewport, in frame coordinates.
  function visibleRect() {
    if (isTop) return Promise.resolve({ left: 0, top: 0, right: innerWidth, bottom: innerHeight });
    const probe = document.createElement("div");
    probe.style.cssText = "all: initial; position: fixed; inset: 0; pointer-events: none; opacity: 0;";
    document.documentElement.append(probe);
    return new Promise((resolve) => {
      const io = new IntersectionObserver(([e]) => {
        io.disconnect();
        probe.remove();
        const r = e.intersectionRect;
        resolve(e.isIntersecting && r.width && r.height ? { left: r.left, top: r.top, right: r.right, bottom: r.bottom } : null);
      });
      io.observe(probe);
    });
  }

  const intersects = (r, v) => r.width > 0 && r.bottom > v.top && r.right > v.left && r.top < v.bottom && r.left < v.right;

  function collectTextNodes(view) {
    const nodes = [];
    const range = document.createRange();
    const walker = document.createTreeWalker(document.body || document.documentElement, NodeFilter.SHOW_TEXT, {
      acceptNode: (n) =>
        n.data.trim() && n.parentElement && !SKIP_TAGS.has(n.parentElement.tagName)
          ? NodeFilter.FILTER_ACCEPT
          : NodeFilter.FILTER_REJECT,
    });
    for (let n; (n = walker.nextNode()); ) {
      range.selectNodeContents(n);
      if (intersects(range.getBoundingClientRect(), view)) nodes.push(n);
    }
    return nodes;
  }

  function findMatches(query) {
    const smartCase = query !== query.toLowerCase();
    const q = smartCase ? query : query.toLowerCase();
    const range = document.createRange();
    const matches = [];
    for (const node of fs.nodes) {
      const text = smartCase ? node.data : node.data.toLowerCase();
      let lastEnd = -1;
      for (let i = text.indexOf(q[0]); i !== -1; i = text.indexOf(q[0], i + 1)) {
        if (i < lastEnd) continue;
        const positions = [i];
        let p = i;
        for (let k = 1; k < q.length; k++) {
          const next = text.indexOf(q[k], p + 1);
          if (next === -1 || next - p - 1 > MAX_GAP) break;
          positions.push((p = next));
        }
        if (positions.length !== q.length) continue;
        range.setStart(node, i);
        range.setEnd(node, i + 1);
        const rect = range.getBoundingClientRect();
        if (!intersects(rect, fs.view)) continue;
        const end = p + 1;
        matches.push({
          node, start: i, end, positions, rect,
          score: end - i - q.length,
          next: text.slice(end, end + MAX_GAP + 1).toLowerCase(),
        });
        lastEnd = end;
      }
    }
    return matches;
  }

  function restore(saved) {
    if (saved) {
      getSelection().setBaseAndExtent(saved.anchorNode, saved.anchorOffset, saved.focusNode, saved.focusOffset);
    }
  }

  const onFrameScroll = () => sendTo(0, { type: "cancel" });

  async function begin() {
    teardown();
    const sel = getSelection();
    const saved = sel.rangeCount && !sel.isCollapsed
      ? { anchorNode: sel.anchorNode, anchorOffset: sel.anchorOffset, focusNode: sel.focusNode, focusOffset: sel.focusOffset }
      : null;
    const view = await visibleRect();
    const style = document.createElement("style");
    style.textContent = pageStyle;
    document.documentElement.append(style);
    const { host, root } = makeOverlay("<div></div>");
    const nodes = view ? collectTextNodes(view) : [];
    const dim = new Highlight();
    for (const n of nodes) {
      const r = document.createRange();
      r.selectNodeContents(n);
      dim.add(r);
    }
    fs = { saved, view, nodes, dim, style, host, labelsEl: root.querySelector("div"), matches: [] };
    if (!isTop) addEventListener("scroll", onFrameScroll, true);
  }

  function query(q) {
    if (!fs) return [];
    fs.labelsEl.replaceChildren();
    CSS.highlights.delete("pounce-match");
    fs.matches = q ? findMatches(q) : [];
    if (!q) {
      CSS.highlights.delete("pounce-dim");
      return [];
    }
    CSS.highlights.set("pounce-dim", fs.dim);
    const hl = new Highlight();
    hl.priority = 1;
    for (const m of fs.matches) {
      for (const p of m.positions) {
        const r = document.createRange();
        r.setStart(m.node, p);
        r.setEnd(m.node, p + 1);
        hl.add(r);
      }
    }
    CSS.highlights.set("pounce-match", hl);
    return fs.matches.map((m, id) => ({ id, score: m.score, next: m.next, top: m.rect.top, left: m.rect.left }));
  }

  function showLabels(list) {
    if (!fs) return;
    fs.labelsEl.replaceChildren();
    for (const [id, label, best] of list) {
      const m = fs.matches[id];
      if (!m) continue;
      const el = document.createElement("span");
      el.className = best ? "label best" : "label";
      el.textContent = label;
      el.style.left = `${m.rect.left}px`;
      el.style.top = `${m.rect.top}px`;
      fs.labelsEl.appendChild(el);
    }
  }

  function teardown() {
    const s = fs;
    fs = null;
    if (!s) return null;
    removeEventListener("scroll", onFrameScroll, true);
    CSS.highlights.delete("pounce-dim");
    CSS.highlights.delete("pounce-match");
    s.style.remove();
    s.host.remove();
    return s;
  }

  function end() {
    const s = teardown();
    if (s) restore(s.saved);
  }

  function accept(id) {
    const m = fs && fs.matches[id];
    const s = teardown();
    if (!m) return;
    if (!isTop) window.focus();
    const sel = getSelection();
    if (!s.saved) {
      sel.setBaseAndExtent(m.node, m.start, m.node, m.end);
      return;
    }
    restore(s.saved);
    const anchor = document.createRange();
    anchor.setStart(s.saved.anchorNode, s.saved.anchorOffset);
    sel.extend(m.node, anchor.comparePoint(m.node, m.start) >= 0 ? m.end : m.start);
  }

  // ---- top-frame prompt ----

  function closeUI() {
    const u = ui;
    ui = null;
    if (!u) return;
    removeEventListener("scroll", cancel, true);
    removeEventListener("resize", cancel, true);
    u.host.remove();
  }

  function cancel() {
    if (!ui) return;
    closeUI();
    end();
    broadcast({ type: "end" });
  }

  function choose(m) {
    closeUI();
    if (m.frameId === 0) {
      accept(m.id);
    } else {
      end();
      sendTo(m.frameId, { type: "accept", id: m.id });
    }
    broadcast({ type: "end" }, [m.frameId]);
  }

  async function onInput() {
    const u = ui;
    const seq = ++u.seq;
    const q = u.input.value;
    await u.ready;
    const local = query(q).map((m) => ({ ...m, frameId: 0 }));
    const replies = await broadcast({ type: "query", q });
    if (ui !== u || seq !== u.seq) return;
    const remote = replies.flatMap(({ frameId, r }) => (r || []).map((m) => ({ ...m, frameId })));
    const all = [...local, ...remote]
      .sort((a, b) => a.score - b.score || (a.frameId !== 0) - (b.frameId !== 0) || a.top - b.top || a.left - b.left)
      .slice(0, MAX_MATCHES);
    const taken = new Set(all.flatMap((m) => [...m.next]));
    const free = [...LABELS].filter((c) => !taken.has(c));

    u.labels.clear();
    u.best = all[0] || null;
    const perFrame = new Map(replies.map(({ frameId }) => [frameId, []]));
    perFrame.set(0, []);
    all.forEach((m, i) => {
      if (i >= free.length) return;
      u.labels.set(free[i], m);
      perFrame.get(m.frameId).push([m.id, free[i], i === 0]);
    });
    for (const [frameId, list] of perFrame) {
      frameId === 0 ? showLabels(list) : sendTo(frameId, { type: "labels", list });
    }
  }

  function onKey(e) {
    e.stopPropagation();
    if (e.key === "Escape") {
      e.preventDefault();
      cancel();
    } else if (e.key === "Enter") {
      e.preventDefault();
      ui.best ? choose(ui.best) : cancel();
    } else if (!e.ctrlKey && !e.altKey && !e.metaKey && ui.labels.has(e.key)) {
      e.preventDefault();
      choose(ui.labels.get(e.key));
    }
  }

  async function activate() {
    if (ui) return cancel();
    await begin();
    const { host, root } = makeOverlay('<input spellcheck="false" autocomplete="off">');
    const input = root.querySelector("input");
    ui = { host, input, seq: 0, labels: new Map(), best: null, ready: broadcast({ type: "begin" }) };
    input.addEventListener("keydown", onKey);
    input.addEventListener("input", onInput);
    input.addEventListener("blur", cancel);
    addEventListener("scroll", cancel, true);
    addEventListener("resize", cancel, true);
    input.focus({ preventScroll: true });
  }

  chrome.runtime.onMessage.addListener((msg, _sender, respond) => {
    switch (msg.type) {
      case "trigger": if (isTop) activate(); break;
      case "begin": begin().then(() => respond(true)); return true;
      case "query": respond(query(msg.q)); break;
      case "labels": showLabels(msg.list); break;
      case "accept": accept(msg.id); break;
      case "end": end(); break;
      case "cancel": if (isTop) cancel(); break;
    }
    return false;
  });
})();

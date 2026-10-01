const trigger = () => {
  chrome.tabs.query({ active: true, lastFocusedWindow: true }, ([tab]) => {
    if (tab) chrome.tabs.sendMessage(tab.id, { type: "trigger" }, { frameId: 0 }, () => void chrome.runtime.lastError);
  });
};

const sendTo = (tabId, frameId, msg) =>
  chrome.tabs.sendMessage(tabId, msg, { frameId }).then((r) => ({ frameId, r }), () => null);

async function broadcast(tabId, msg, skip) {
  const frames = (await chrome.webNavigation.getAllFrames({ tabId })) || [];
  return Promise.all(frames.filter((f) => !skip.includes(f.frameId)).map((f) => sendTo(tabId, f.frameId, msg)));
}

// Vimium C: map s sendToExtension id=<this extension id> data=pounce
chrome.runtime.onMessageExternal.addListener((_msg, _sender, sendResponse) => {
  trigger();
  sendResponse(true);
});

chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {
  const tabId = sender.tab.id;
  if (msg.type === "broadcast") {
    broadcast(tabId, msg.msg, [sender.frameId, ...(msg.skip || [])]).then(sendResponse);
  } else if (msg.type === "send") {
    sendTo(tabId, msg.frameId, msg.msg).then(sendResponse);
  } else {
    return false;
  }
  return true;
});

chrome.commands.onCommand.addListener((cmd) => cmd === "pounce" && trigger());

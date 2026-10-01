# Vimium C

Vim-style key mappings for [Vimium C](https://github.com/gdh1995/vimium-c), aligned with my nvim
(`<space>` leader, `S-h`/`S-l` buffers, fzf-lua `<leader>f*`) and tmux (`C-h`/`C-l` windows).

**Import:** Vimium C Options → Advanced settings → "Import settings" → `vimium-c-settings.json`.
Only `keyMappings` is overridden; Vimium C defaults not listed there stay active.

## Modes

- **Normal** — keys are commands (no text field focused).
- **Insert** — a text field is focused, keys type. `Esc`, `<c-[>` or `<c-j>` exit.
- **Pass-through** — `i` hands all keys to the page until `Esc` (Gmail, Jira, YouTube shortcuts).
- `?` — help sheet with every active binding.

## Page movement

| Keys | Action |
|---|---|
| `j` / `k` | scroll down / up |
| `h` / `l` | scroll left / right |
| `<c-d>` / `<c-u>` | half page down / up |
| `<c-f>` / `<c-b>` | full page down / up |
| `gg` / `G` | top / bottom |
| `0` / `$` | far left / right |

## Links (pounce-style)

| Keys | Action |
|---|---|
| `<enter>` or `f` | hints, type label to click |
| `F` or `gx` | open in new background tab |
| `<a-f>` | hint mode stays open, open many |
| `yf` | copy link URL |
| `yv` | select an element's text |

Typing part of the link text filters hints. `Esc` cancels.

## History

| Keys | Action |
|---|---|
| `<c-o>` / `<c-i>` | back / forward (jumplist) |
| `gu` / `gh` | one URL level up / site root |
| `[[` / `]]` | page's prev / next link |

## Tabs

| Keys | Action |
|---|---|
| `H` / `L`, `<c-h>` / `<c-l>` | prev / next tab |
| `J` / `K`, `gT` / `gt` | prev / next tab (defaults) |
| `^` | last visited tab |
| `g0` / `g$` | first / last tab |
| `<<` / `>>` | move tab left / right |
| `tt` (or `t`) | new tab |
| `xx`, `dd`, `ZZ`, `<space>c` | close tab |
| `u` (or `X`) | reopen closed tab |
| `<space>bo` | close other tabs |
| `<space>vs` | move tab to new window |
| `<a-p>` / `<a-m>` | pin / mute |

## Fuzzy search (Vomnibar)

| Keys | Action |
|---|---|
| `<space>fj` (or `T`) | open tabs |
| `<space>ff`, `o`, `:`, `;` | URL / search / history / bookmarks |
| `<space>fF` (or `O`) | same, open in new tab |
| `<space>fh` | history |
| `<space>fb` (or `b`) | bookmarks |
| `ge` | edit current URL |

Inside: `<c-j>`/`<c-k>` (or `<c-n>`/`<c-p>`) move, `Enter` open, `Shift+Enter` new tab, `Esc` close.

## Form fields

| Keys | Action |
|---|---|
| `gi` | focus first text input |
| `3gi` | focus 3rd input |
| `Tab` / `Shift+Tab` | after `gi`: next / previous input |
| `f` + label | focus a specific field |
| `Esc` / `<c-j>` | back to normal mode |

## Find

| Keys | Action |
|---|---|
| `/` or `<space>fs` | find, `Enter` confirms (match is selected) |
| `n` / `N` | next / previous match |
| `*` / `#` | find selection forward / backward |

`Enter` on a confirmed link match clicks it.

## Visual mode and copy

| Keys | Action |
|---|---|
| `v` / `V` | visual / line visual (starts from current selection) |
| `w` `e` `b` `$` `j` `}` `)` + counts | extend selection |
| `o` | swap selection end |
| `y` | copy selection, exit |
| `yy` or `<space>yf` | copy page URL |
| `<space>yr` | copy page title |
| `p` / `P` | open clipboard URL here / new tab |

Selecting between two words: `/start` `Enter`, `v`, extend with motions (or Shift+click the end), `y`.
`/` inside visual mode does not extend the selection.

## Pounce (fuzzy jump to visible text)

Companion extension in `pounce/`. Load it via `chrome://extensions` → Developer mode → "Load
unpacked". The fixed `key` in its manifest pins the ID to `jbjllgdmphchokkcjjefbjkcebfnpcme`, which
the `s` mapping targets. `Alt+.` triggers it without Vimium C.

| Keys | Action |
|---|---|
| `s` + query | dim page, highlight fuzzy matches in the viewport (smartcase, ≤2-char gaps) |
| label | select that match (green label = best) |
| `Enter` | select best match |
| `Esc` | cancel, restore previous selection |

Searches all frames, including cross-origin iframes, clipped to what's actually visible (needs the
`webNavigation` permission to enumerate frames). Jumping into an iframe focuses it, so Vimium C's
`v`/`y` act there. With a selection already active in that frame, the jump extends it instead. Selecting between two words:
`/start` `Enter`, `s` + end word + label, then `v` to adjust or `y`.

## Marks

| Keys | Action |
|---|---|
| `ma` | local mark `a` |
| `mA` | global mark `A` (cross-tab) |
| `` `a `` or `'a` | jump to mark |

## Frames and interactive sites

| Keys | Action |
|---|---|
| `gf` / `gF` | next iframe / main frame |
| `i` | pass keys to the page until `Esc` |

- JS-only clickables (div buttons, tabs, tree nodes) usually still get `f` hints.
- Inner scroll panes: click or `f` into the pane once, then `j`/`k` scroll it.
- Canvas/SVG widgets get no hints — mouse, or `Tab` + `Enter`.
- Disable per site: toolbar icon → exclusion rule (empty pass keys = fully off, or list keys
  like `j k x` to give only those to the site).

## Gotchas

- `x`, `d`, `<space>` are prefixes, so their single-key forms wait for the next key.
- `0` is mapped, so counts like `10j` don't work.
- `<c-l>` overrides Chrome's address-bar focus, `<enter>` overrides activating a Tab-focused link.
- `chrome://` pages and the Web Store block extensions.

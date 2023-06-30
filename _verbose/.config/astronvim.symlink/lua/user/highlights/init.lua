local c = require("vscode.colors").get_colors()

local init = {
  -- this table overrides highlights in all themes
  PounceMatch = {
    underline = false,
    bold = false,
    fg = c.vscMediumBlue,
    bg = c.vscCursorDark,
  },
  PounceGap = {
    underline = false,
    bold = false,
    fg = c.vscLineNumber,
    bg = c.vscCursorDark,
  },
  PounceAccept = {
    underline = true,
    bold = true,
    fg = c.vscFront,
    bg = c.vscCursorDark,
  },
  PounceAcceptBest = {
    underline = true,
    bold = true,
    fg = c.vscFront,
    bg = c.vscCursorDark,
  },
  PounceUnmatched = {
    underline = false,
    bold = false,
    fg = c.vscLineNumber,
    bg = c.vscBack,
  },

  -- Group below is making to highlight the current window, together with
  -- Gutters etc. Related to `transparent = false`, option of the `VSCode` theme.
  -- `NC` are non-current. The color corresponds to my unfocused color for
  -- e.g. tmux panes etc.
  NormalNC = {
    bg = c.vscCursorDarkDark,
  },
  WinBarNC = {
    bg = c.vscCursorDarkDark,
  },
  LineNr = {
    fg = c.vscLineNumber,
    bg = "NONE",
  },
  CursorLineNr = {
    fg = c.vscPopupFront,
    bg = "NONE",
  },
  SignColumn = {
    bg = "NONE",
  },
  StatusLine = {
    bg = c.vscCursorDarkDark,
  },
  -- NormalFloat = { -- overrides the floating windows
  --   bg = activeBgColor,
  -- },
  -- TelescopeBorder = {
  --   bg = activeBgColor,
  -- },
  -- TelescopeNormal = {
  --   bg = "NONE",
  -- },
  -- TelescopePromptBorder = {
  --   bg = activeBgColor,
  -- },
  TelescopePromptNormal = {
    bg = c.vscCursorDarkDark,
  },
  -- TelescopeResultsBorder = {
  --   bg = activeBgColor,
  -- },
  -- TelescopeResultsNormal = {
  --   bg = activeBgColor,
  -- },
  -- TelescopePreviewBorder = {
  --   bg = activeBgColor,
  -- },
  -- TelescopePreviewNormal = {
  --   bg = activeBgColor,
  -- },
}

return init

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
  NormalNC = { bg = c.vscLeftDark },
  WinBarNC = { bg = c.vscLeftDark },
  LineNr = { fg = c.vscLineNumber, bg = "NONE" },
  CursorLineNr = { fg = c.vscPopupFront, bg = "NONE" },
  SignColumn = { bg = "NONE" },
  TelescopeBorder = { fg = c.vscLineNumber, bg = c.vscBack },
  TelescopeNormal = { bg = c.vscBack },
  TelescopePromptBorder = { fg = c.vscLineNumber, bg = c.vscBack },
  TelescopePromptNormal = { bg = c.vscBack },
  TelescopeResultsBorder = { fg = c.vscLineNumber, bg = c.vscBack },
  TelescopeResultsNormal = { bg = c.vscBack },
  TelescopePreviewBorder = { fg = c.vscLineNumber, bg = c.vscBack },
  TelescopePreviewNormal = { bg = c.vscBack },
  TabLineFill = { fg = c.vscFront, bg = c.vscLeftMid },
  Directory = { fg = c.vscBlue, bg = "NONE" },
  -- Preview for nvim-bqf
  -- BqfPreviewFloat = { bg = c.vscBack },
}

return init

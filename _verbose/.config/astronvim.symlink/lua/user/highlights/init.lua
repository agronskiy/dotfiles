local c = require("vscode.colors").get_colors()

local init = {
  -- this table overrides highlights in all themes
  PounceMatch = {
    underline = false,
    bold = true,
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
  -- `NC` are non-current. The color corresponds to my unfocused color for
  -- e.g. tmux panes etc.
  -- NormalNC = {
  --   bg = inactiveBgColor,
  -- },
  -- WinBarNC = {
  --   bg = inactiveBgColor,
  -- },
  -- NormalFloat = { -- overrides the floating windows
  --   bg = activeBgColor,
  -- },
  -- TelescopeBorder = {
  --   bg = activeBgColor,
  -- },
  -- TelescopeNormal = {
  --   bg = activeBgColor,
  -- },
  -- TelescopePromptBorder = {
  --   bg = activeBgColor,
  -- },
  -- TelescopePromptNormal = {
  --   bg = activeBgColor,
  -- },
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

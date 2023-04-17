local highlights = {
  init = {
    -- this table overrides highlights in all themes
    PounceMatch = {
      underline = true,
      bold = true,
      bg = vim.api.nvim_get_hl_by_name("Normal", true).background,
      fg = "#FF00FF",
    },
    PounceGap = {
      underline = true,
      bold = false,
      bg = vim.api.nvim_get_hl_by_name("Normal", true).background,
      fg = "#FF00FF",
    },
    PounceAccept = {
      underline = true,
      bold = true,
      bg = vim.api.nvim_get_hl_by_name("Normal", true).background,
      fg = "#00FFFF",
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
  -- duskfox = { -- a table of overrides/changes to the duskfox theme
  --   Normal = { bg = "#000000" },
  -- },
}

return highlights

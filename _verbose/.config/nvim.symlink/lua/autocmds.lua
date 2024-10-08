vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "BufWritePre" }, {
  desc = "Autocmd for file events",
  group = vim.api.nvim_create_augroup("file_user_events", { clear = true }),
  callback = function(args)
    local current_file = vim.fn.resolve(vim.fn.expand "%")
    if not (current_file == "" or vim.api.nvim_get_option_value("buftype", { buf = args.buf }) == "nofile") then
      vim.api.nvim_exec_autocmds("User", { pattern = "FileOpened", modeline = false })
    end
  end,
})


-- Cause quickfix to close after choosing
vim.api.nvim_create_autocmd(
  "FileType", {
    pattern = { "qf" },
    callback = function()
      vim.api.nvim_buf_set_keymap(0, "n", "<cr>", "<cr>:cclose<cr>", {})
    end
  })

-- Make and autocmd so that curr window loses focus when the whole vim
-- loses focus.
-- create an augroup to easily manage autocommands
local auto_win_group = vim.api.nvim_create_augroup("autowinmanagement", { clear = true })
local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
local normal_nc_bg = vim.api.nvim_get_hl(0, { name = "NormalNC", link = false }).bg
vim.api.nvim_create_autocmd({ "FocusLost" }, {
  desc = "Make currwindow look inactive", -- nice description
  group = auto_win_group,                 -- add the autocmd to the newly created augroup
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = normal_nc_bg })
    vim.api.nvim_set_hl(0, "WinBar", { bg = normal_nc_bg })
  end,
})
vim.api.nvim_create_autocmd({ "FocusGained" }, {
  desc = "Make currwindow look active", -- nice description
  group = auto_win_group,               -- add the autocmd to the newly created augroup
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = normal_bg })
    vim.api.nvim_set_hl(0, "WinBar", { bg = normal_bg })
  end,
})

-- Bazel keymaps, see https://github.com/alexander-born/bazel.nvim#vim-functions
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = "bzl",
    callback = function()
      vim.keymap.set("n", "gd", vim.fn.GoToBazelDefinition,
        { buffer = true, desc = "Goto Bazel Definition" })
      vim.keymap.set("n", "gp", function()
          -- Create split then go to def
          -- https://www.reddit.com/r/neovim/comments/mbh7kp/lua_api_to_create_a_split_window/
          vim.cmd("vsplit")
          vim.fn.GoToBazelDefinition()
        end,
        { buffer = true, desc = "Goto Bazel Definition in split" })
    end,
  }
)

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Quit if more than one window is open and only sidebar windows are list",
  group = vim.api.nvim_create_augroup("auto_quit", { clear = true }),
  callback = function()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    -- Both neo-tree and aerial will auto-quit if there is only a single window left
    if #wins <= 1 then return end
    local sidebar_fts = { aerial = true, ["neo-tree"] = true }
    for _, winid in ipairs(wins) do
      if vim.api.nvim_win_is_valid(winid) then
        local bufnr = vim.api.nvim_win_get_buf(winid)
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
        -- If any visible windows are not sidebars, early return
        if not sidebar_fts[filetype] then
          return
          -- If the visible window is a sidebar
        else
          -- only count filetypes once, so remove a found sidebar from the detection
          sidebar_fts[filetype] = nil
        end
      end
    end
    if #vim.api.nvim_list_tabpages() > 1 then
      vim.cmd.tabclose()
    else
      vim.cmd.qall()
    end
  end,
})

local q_win_group = vim.api.nvim_create_augroup("q_close_windows", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Make q close help, man, quickfix, dap  floats",
  group = q_win_group,
  callback = function(args)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
    if (vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype)) then
      vim.keymap.set("n", "q", ":close<cr>", {
        desc = "Close window",
        buffer = args.buf,
        silent = true,
        nowait = true,
      })
    end
  end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Credit of:
-- https://github.com/creativenull/dotfiles/blob/9ae60de4f926436d5682406a5b801a3768bbc765/config/nvim/init.lua#L70-L86
-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid, when inside an event handler
-- (happens when dropping a file on gvim) and for a commit message (it's
-- likely a different one than last time).
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("restore_file_position", { clear = true }),
  callback = function(args)
    local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line("$")
    local not_commit = vim.b[args.buf].filetype ~= "commit"

    if valid_line and not_commit then
      vim.cmd([[normal! g`"]])
    end
  end,
})

-- https://github.com/linrongbin16/lsp-progress.nvim
-- listen lsp-progress event and refresh lualine
vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
  group = "lualine_augroup",
  pattern = "LspProgressStatusUpdated",
  callback = require("lualine").refresh,
})

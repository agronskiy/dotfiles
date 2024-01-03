-- Cause quickfix to close after choosing
vim.api.nvim_create_autocmd(
  "FileType", {
    pattern = { "qf" },
    callback = function()
      vim.api.nvim_buf_set_keymap(0, "n", "<cr>", "<cr>:cclose<cr>", {})
    end
  })

-- Create specific bindings for TeX
vim.api.nvim_create_augroup("mytex", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter", "FileType" }, {
  desc = "Bindings for LaTeX",
  group = "mytex",
  pattern = "tex",
  callback = function()
    if vim.bo.filetype == "tex" then
      vim.api.nvim_buf_set_keymap(0, "n", "<leader>lv", "<cmd>VimtexView<cr>", {})
      vim.api.nvim_buf_set_keymap(0, "n", "<leader>lc", "<cmd>VimtexCompile<cr>", {})

      -- Set vim servername for callbacks from Skim (for inverse search). Setup of the
      -- Skim->Preferences->Synk is thus:
      --   Command:   nvr
      --   Arguments: --servername `cat /tmp/curnvimserver.txt` +"%line" "%file"
      local nvim_server_file = "/tmp/curnvimserver.txt"
      local servername = vim.v.servername
      local cmd = vim.fn.printf("echo %s > %s", servername, nvim_server_file)
      vim.fn.system(cmd)
    end
  end,
})


-- Make and autocmd so that curr window loses focus when the whole vim
-- loses focus.
-- create an augroup to easily manage autocommands
local auto_win_group = vim.api.nvim_create_augroup("autowinmanagement", { clear = true })
local NORMAL_BG = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
local NORMAL_NC_BG = vim.api.nvim_get_hl(0, { name = "NormalNC", link = false }).bg
vim.api.nvim_create_autocmd({ "FocusLost" }, {
  desc = "Make currwindow look inactive", -- nice description
  group = auto_win_group,                 -- add the autocmd to the newly created augroup
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = NORMAL_NC_BG })
    vim.api.nvim_set_hl(0, "WinBar", { bg = NORMAL_NC_BG })
  end,
})
vim.api.nvim_create_autocmd({ "FocusGained" }, {
  desc = "Make currwindow look active", -- nice description
  group = auto_win_group,               -- add the autocmd to the newly created augroup
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = NORMAL_BG })
    vim.api.nvim_set_hl(0, "WinBar", { bg = NORMAL_BG })
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
    local sidebar_fts = { aerial = true,["neo-tree"] = true }
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

vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Make q close help, man, quickfix, dap floats",
  group = vim.api.nvim_create_augroup("q_close_windows", { clear = true }),
  callback = function(args)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
    if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) and vim.fn.maparg("q", "n") == "" then
      vim.keymap.set("n", "q", "<cmd>close<cr>", {
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

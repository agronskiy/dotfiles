-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")
      [1]
  if vim.v.shell_error ~= 0 then
    print "Not a git repository. Searching on current working directory"
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require("telescope.builtin").live_grep {
      search_dirs = { git_root },
    }
  end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

-- Vertical split
vim.keymap.set({ "n", "v" }, "<leader>vs", function()
    vim.cmd("vsplit")
  end,
  { desc = "Vertical split" }
)
-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>fj", function()
    require("telescope.builtin").buffers({ sort_lastused = true, ignore_current_buffer = true })
  end,
  { desc = "find existing buffers" })
vim.keymap.set('n', '<leader>ss', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre Search"
})
vim.keymap.set("n", "<leader>fs", function()
    require("telescope.builtin").current_buffer_fuzzy_find({
      layout_strategy = "horizontal",
    })
  end,
  { desc = "search current buffer" })
vim.keymap.set("n", "<leader>fF", require("telescope.builtin").git_files, { desc = "search git files" })
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "find files" })
vim.keymap.set("n", "<leader>fc", require("telescope.builtin").grep_string, { desc = "find current word" })
vim.keymap.set("n", "<leader>fw", require("telescope.builtin").live_grep, { desc = "find word" })
vim.keymap.set("n", "<leader>fh", function()
    require("telescope.builtin").oldfiles({ cwd_only = true })
  end,
  { desc = "find local history" }
)
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope grapple tags<cr>", { desc = "grapple tags" })
vim.keymap.set("n", "<leader>fW", "<cmd>LiveGrepGitRoot<cr>", { desc = "search by grep in git" })
vim.keymap.set("n", "<leader>ld", require("telescope.builtin").diagnostics, { desc = "seach diagnostics" })
vim.keymap.set("n", "<leader>lr", require("telescope.builtin").lsp_references, { desc = "find references" })
vim.keymap.set("n", ";", ":")


-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- Avoid yank-on-paste and yank-on-edit (yank-on-delete remains)
vim.keymap.set("v", "p", '"_dP', { noremap = true })
vim.keymap.set("v", "c", '"_c', { noremap = true })
vim.keymap.set("v", "x", '"_x', { noremap = true })
vim.keymap.set("v", "<", "<gv", { desc = "unindent line" })
vim.keymap.set("v", ">", ">gv", { desc = "indent line" })


-- Pounce: jumping to arbitrary place in the visible screen.
vim.keymap.set({ "o", "v" }, "<cr>",
  function()
    -- Logic: in visual mode, it's often beneficial to select up to the end of word found by
    -- `pounce.nvim`.
    local start_pos = vim.api.nvim_win_get_cursor(0)
    require("pounce").pounce()
    local end_pos = vim.api.nvim_win_get_cursor(0)
    if end_pos[1] < start_pos[1]
        or (end_pos[1] == start_pos[1] and end_pos[2] <= start_pos[2])
        or end_pos[2] == 0 then
      return
    end
    -- At this point, if we are in the middle of word, we want to move to the end.
    -- Get the current line
    local line = vim.api.nvim_get_current_line()
    -- Get the character under the cursor, and if it's alphanumeric or `[-_]`, meaning we're inside
    -- of a word, we move to the end.
    local char = string.sub(line, end_pos[2] + 1, end_pos[2] + 1)
    local is_alphanumeric = char:match('%w') ~= nil
    local is_score = char == '-' or char == '_'
    if is_alphanumeric or is_score then
      vim.api.nvim_feedkeys('e', 'n', false)
    end
  end,
  { desc = "Fuzzy hop (before) with pounce" }
)
vim.keymap.set({ "n" }, "<cr>", require("pounce").pounce, { desc = "Fuzzy hop with pounce" })

-- Useful for editing
vim.keymap.set("i", "jj", "<esc>la", { desc = "Move one symbol right" })
vim.keymap.set("i", "jl", "<esc>A", { desc = "Move to the end and continue edit" })
vim.keymap.set("i", "jh", "<esc>^i", { desc = "Move to the begin and continue edit" })

-- Buffer navigation and manipulation
vim.keymap.set("n", "<S-l>", function() require("bufferline.commands").cycle(1) end, { desc = "Move right" })
vim.keymap.set("n", "<S-h>", function() require("bufferline.commands").cycle(-1) end, { desc = "Move left" })
vim.keymap.set("n", "<leader>c", function() require("bufdelete").bufdelete(0, true) end,
  { desc = "Close buffer" })

local delete_all_invisible = function()
  local bufinfos = vim.fn.getbufinfo({ buflisted = true })
  vim.tbl_map(function(bufinfo)
    if bufinfo.changed == 0 and (not bufinfo.windows or #bufinfo.windows == 0) then
      require("bufdelete").bufdelete(bufinfo.bufnr, true)
    end
  end, bufinfos)
end

-- Delete all invisible buffers ([b]uffer-[o]nly)
vim.keymap.set("n", "<leader>bo", delete_all_invisible, { desc = 'Keep only visible buffers' })

-- `F` for `Focus`: it moves to the leftmost split and keeps only it, closing all the other
-- buffer. Useful for a round of exploration in the code.
vim.keymap.set("n", "<leader>F",
  function()
    for _ = 1, 7 do
      vim.cmd("wincmd h")
    end
    vim.cmd("only")
    delete_all_invisible()
  end,
  { desc = "Move left and focus" }
)

-- Similar, `Z` for `Zen` focuses on the current window, closes all other buffers
vim.keymap.set("n", "<leader>Z",
  function()
    vim.cmd("only")
    delete_all_invisible()
  end,
  { desc = "Focus on current" }
)

-- Avoid yank-on-edit
vim.keymap.set({ "n", "v" }, "c", '"_c', { noremap = true })
vim.keymap.set("n", "C", '"_C', { noremap = true })
-- Line deletion without yank (quite often used)
vim.keymap.set("n", "xx", '"_dd', { noremap = true })
vim.keymap.set("v", "x", '"_x', { noremap = true })
vim.keymap.set("n", "X", '"_x', { noremap = true })
-- Avoid yank-on-paste
vim.keymap.set("v", "p", '"_dP', { noremap = true })

vim.keymap.set("n", "<leader>yf",
  function()
    local path = vim.fn.expand("%:p")
    vim.api.nvim_command("let @\" = '" .. path .. "'")
    require("osc52").copy_register("")
    vim.notify('Copied "' .. path .. '" to the clipboard!')
  end,
  { desc = "Yank current [f]ull filepath" })

-- Opening quickfix
vim.keymap.set("n", "qq", ":copen<cr>", { desc = "Open quickfix" })

-- Command to copy relative path, credit of
-- https://www.reddit.com/r/neovim/comments/u221as/how_can_i_copy_the_current_buffers_relative_path/
vim.keymap.set("n", "<leader>yr",
  function()
    local path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
    vim.api.nvim_command("let @\" = '" .. path .. "'")
    require("osc52").copy_register("")
    vim.notify('Copied "' .. path .. '" to the clipboard!')
  end,
  { desc = "Yank current [r]elative filepath" })

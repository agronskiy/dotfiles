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

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>fo", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "<leader>ss", require("telescope.builtin").builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>fs", function()
    require("telescope.builtin").current_buffer_fuzzy_find({
      layout_strategy = "horizontal",
    })
  end,
  { desc = "Search current buffer" })
vim.keymap.set("n", "<leader>fF", require("telescope.builtin").git_files, { desc = "Search git files" })
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>fc", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>fw", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>fo", require("telescope.builtin").oldfiles, { desc = "Find history" })
vim.keymap.set("n", "<leader>fW", ":LiveGrepGitRoot<cr>", { desc = "Search by grep in git" })
vim.keymap.set("n", "<leader>ld", require("telescope.builtin").diagnostics, { desc = "Seach diagnostics" })
vim.keymap.set("n", "<leader>fo", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", ";", ":")


-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- Open preview in split
-- Additional keymaps
vim.keymap.set("n", "gp", "<cmd>vert winc ]<cr>", { desc = "Open preview in split" })

-- Avoid yank-on-paste and yank-on-edit (yank-on-delete remains)
vim.keymap.set("v", "p", '"_dP', { noremap = true })
vim.keymap.set("v", "c", '"_c', { noremap = true })
vim.keymap.set("v", "x", '"_x', { noremap = true })
vim.keymap.set("v", "<", "<gv", { desc = "unindent line" })
vim.keymap.set("v", ">", ">gv", { desc = "indent line" })


-- Pounce
vim.keymap.set("v", "t", function()
    -- Logic: in visual mode, it's often beneficial to select one symbol _before_ the
    -- end point found by `pounce.nvim`. So below is the comparison of the before/after
    -- positions, and if the seleciton goes "forward", we set the cursor one symbol left
    local start_pos = vim.api.nvim_win_get_cursor(0)
    require("pounce").pounce()
    local end_pos = vim.api.nvim_win_get_cursor(0)
    if end_pos[1] < start_pos[1]
        or (end_pos[1] == start_pos[1] and end_pos[2] <= start_pos[2])
        or end_pos[2] == 0 then
      return
    end
    vim.api.nvim_win_set_cursor(0, { end_pos[1], end_pos[2] - 1 })
  end,
  { desc = "Fuzzy hop (before) with pounce" }
)
vim.keymap.set({ "n", "v" }, "f", require("pounce").pounce, { desc = "Fuzzy hop with pounce" })

-- Useful for editing
vim.keymap.set("i", "jj", "<esc>la", { desc = "Move one symbol right" })
vim.keymap.set("i", "jl", "<esc>A", { desc = "Move to the end and continue edit" })
vim.keymap.set("i", "jh", "<esc>^i", { desc = "Move to the end and continue edit" })

-- Buffer navigation
local function nav(n)
  local current = vim.api.nvim_get_current_buf()
  for i, v in ipairs(vim.t.bufs) do
    if current == v then
      vim.cmd.b(vim.t.bufs[(i + n - 1) % #vim.t.bufs + 1])
      break
    end
  end
end
vim.keymap.set("n", "<S-l>", function() nav(vim.v.count > 0 and vim.v.count or 1) end, { desc = "Move right" })
vim.keymap.set("n", "<S-h>", function() nav(-(vim.v.count > 0 and vim.v.count or 1)) end, { desc = "Move left" })

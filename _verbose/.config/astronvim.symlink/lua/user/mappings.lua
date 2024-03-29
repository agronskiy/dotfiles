-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bo"] = {
      function()
        require("astronvim.utils.buffer").close_all({ keep_current = true })
      end,
      desc = "Close other tabs",
    },
    ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
    ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
    ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
    [";"] = ":",
    ["<leader>fs"] = {
      function()
        require("telescope.builtin").current_buffer_fuzzy_find({
          layout_strategy = "horizontal",
        })
      end,
      desc = "Search current buffer",
    },
    ["<leader>fc"] = {
      function()
        require("telescope.builtin").commands()
      end,
      desc = "Search commands",
    },
    ["<leader>fh"] = {
      function()
        require("telescope.builtin").command_history()
      end,
      desc = "Search command history",
    },
    ["<leader>fm"] = {
      function()
        require("telescope.builtin").live_grep({
          additional_args = function()
            return { "--multiline", "--multiline-dotall" }
          end,
        })
      end,
      desc = "Search multiline",
    },
    ["qq"] = { ":copen<cr>", desc = "Open quickfix" },
    ["qj"] = { ":colder<cr>", desc = "Open older quickfix" },
    ["qk"] = { ":cnewer<cr>", desc = "Open newer quickfix" },
    ["qh"] = {
      function()
        require("telescope.builtin").quickfixhistory()
      end,
      desc = "Open quickfix",
    },
    ["mo"] = { -- `o` for `oll` :D
      function()
        local bookmark_actions = require("telescope").extensions.vim_bookmarks.actions
        require("telescope").extensions.vim_bookmarks.all({
          -- https://github.com/tom-anders/telescope-vim-bookmarks.nvim#customization
          width_text = 40,
          attach_mappings = function(_, map)
            map("n", "dd", bookmark_actions.delete_selected_or_at_cursor)
            map("i", "dd", bookmark_actions.delete_selected_or_at_cursor)
            return true
          end
        })
      end,
      desc = "Show all bookmarks",
    },
    -- Buffer navigation
    ["<S-l>"] = {
      -- Astonvim's support is better if we just reuse
      function()
        require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
      end,
      desc = "Next buffer",
    },
    ["<S-h>"] = {
      function()
        require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
      end,
      desc = "Previous buffer",
    },
    -- Navigating within wrapped lines
    ["k"] = { "gk" },
    ["j"] = { "gj" },
    -- Opens preview in the split on the right.
    ["gp"] = { "<cmd>vert winc ]<cr>", desc = "Open preview in split" },
    -- Hop command to quickly go to bigram
    ["t"] = {
      function()
        require("hop").hint_char1()
      end,
      desc = "Hop to symbol",
    },
    ["f"] = {
      function()
        require("pounce").pounce()
      end,
      desc = "Fuzzy hop with pounce",
    },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    ["gf"] = false, -- Disable `go to file under cursor`
    -- `name`-only key will be registered with which-key
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>F"] = {
      -- `F` for `Focus`: it moves to the leftmost split and leaves only it, closing all the other
      -- buffer. Useful for a round of exploration in the code.
      function()
        for _ = 1, 7 do
          vim.cmd("wincmd h")
        end
        require("astronvim.utils.buffer").close_all({ keep_current = true })
        vim.cmd("only")
      end,
      desc = "Close other tabs and windows",
    },
    -- Avoid yank-on-edit
    ["c"] = { '"_c', noremap = true },
    ["C"] = { '"_C', noremap = true },
    -- Line deletion without yank (quite often used)
    ["xx"] = { '"_dd', noremap = true },
    ["X"] = { "x", noremap = true },
    -- Bazel commands
    ["gbt"] = { vim.fn.GoToBazelTarget, desc = "Goto Bazel Target" },
  },
  i = {
    ["jj"] = { "<esc>la", desc = "Move one symbol right" },
    -- Useful when editing and inside autoclosed quotes
    ["jl"] = { "<esc>A", desc = "Move to the end and continue edit" },
    ["jh"] = { "<esc>^i", desc = "Move to the end and continue edit" },
  },
  v = {
    -- navigating wrapped lines
    j = { "gj", desc = "Navigate down" },
    k = { "gk", desc = "Navigate down" },
    -- Quickly jump to fuzzy - before
    ["t"] = {
      function()
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
      desc = "Fuzzy hop (before) with pounce",
    },
    ["f"] = {
      function()
        require("pounce").pounce()
      end,
      desc = "Fuzzy hop with pounce",
    },
    -- Avoid yank-on-paste and yank-on-edit (yank-on-delete remains)
    ["p"] = { '"_dP', noremap = true },
    ["c"] = { '"_c', noremap = true },
    -- Deletion without yank
    ["x"] = { '"_x', noremap = true },
    -- Stay in indent mode
    ["<"] = { "<gv", desc = "unindent line" },
    [">"] = { ">gv", desc = "indent line" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}

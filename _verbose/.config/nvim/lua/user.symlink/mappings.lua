-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bo"] = { "<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>", desc = "Close other tabs" },
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
    -- Hop command to quickly go to uni/bi-graom
    ["w"] = {
      function()
        require("hop").hint_words()
      end,
      desc = "Hop to word",
    },
    ["t"] = {
      function()
        require("hop").hint_char1()
      end,
      desc = "Hop to char",
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
  },
  i = {
    ["jj"] = { "<esc>la", desc = "Move one symbol right" },
    -- Useful when editing and inside autoclosed quotes
    ["jl"] = { "<esc>A", desc = "Move to the end and continue edit" },
  },
  v = {
    -- navigating wrapped lines
    j = { "gj", desc = "Navigate down" },
    k = { "gk", desc = "Navigate down" },
    -- Hop command to quickly go to bigram
    ["w"] = {
      function()
        require("hop").hint_words()
      end,
      desc = "Hop to word",
    },
    ["t"] = {
      function()
        require("hop").hint_char1()
      end,
      desc = "Hop to char",
    },
    ["f"] = {
      function()
        require("pounce").pounce()
      end,
      desc = "Fuzzy hop with pounce",
    },
    ["<leader>c"] = { ":'<,'>OSCYank<CR>", desc = "Yank to OSC52 clipboard", noremap = true },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}

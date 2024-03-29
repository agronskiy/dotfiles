-- Colors are synced with tmux.conf (`window-style`, `window-active-style`, `pane-border-style` etc)
local activeBgColor = "#1c1c1c"

return {
  {
    "max397574/better-escape.nvim",
    opts = {
      -- Removed `jj` because I have better use for it.
      mapping = { "jk" },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "alexander-born/cmp-bazel",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = function(_, opts)
      opts.sources = require("cmp").config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        {
          name = "buffer",
          priority = 500,
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
        },
        { name = "path", priority = 250 },
        { name = "bazel", priority = 250 },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },
  {
    "akinsho/toggleterm.nvim",
    opts = {
      border = "single",
      -- like `size`, width and height can be a number or function which is passed the current terminal
      width = function()
        return math.ceil(vim.o.columns * 0.87)
      end,
      height = function()
        return math.ceil(vim.o.lines * 0.85)
      end,
    },
  },

  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require("astronvim.utils.status")

      opts.statusline = {
        -- statusline
        hl = { fg = "fg", bg = "bg" },
        status.component.mode({
          mode_text = { padding = { left = 1, right = 1 } },
        }),
        status.component.git_branch(),
        status.component.file_info({
          -- enable the file_icon and disable the highlighting based on filetype
          file_icon = false,
          -- See here https://vimhelp.org/cmdline.txt.html#filename-modifiers
          filename = { modify = ":p:.", padding = { left = 0 } },
          -- add padding
          padding = { right = 0 },
        }),
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.treesitter(),
        status.component.nav(),
        status.component.mode({ surround = { separator = "right" } }),
      }
      return opts
    end,
  },
  {
    "stevearc/aerial.nvim",
    opts = {
      keymaps = {
        ["<CR>"] = {
          callback = function()
            require("aerial").select()
            vim.cmd("AerialClose")
          end,
        },
      },
    },
  },
}

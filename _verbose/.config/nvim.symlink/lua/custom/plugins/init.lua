-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    branch = "main",
    config = function()
      local c = require("vscode.colors").get_colors()
      require("vscode").setup({
        transparent = false,
        -- Override colors (see ./lua/vscode/colors.lua)
        color_overrides = {
          -- Approx of color 256 but slightly darker
          vscLeftDark = "#282828",
          vscCursorDarkDark = "#303030",
        },
        -- Override highlight groups (see ./lua/vscode/theme.lua)
        group_overrides = {
          -- this supports the same val table as vim.api.nvim_set_hl
          -- use colors from this colorscheme by requiring vscode.colors!
          ["@text.reference"] = { fg = c.vscLightBlue, bg = "NONE" },
          ["@text.uri"] = { fg = c.vscOrange, bg = "NONE" },
          ["@text.todo.unchecked"] = { fg = c.vscOrange, bg = "NONE" },
          ["@text.todo.checked"] = { fg = c.vscOrange, bg = "NONE" },
          ["@text.quote"] = { fg = c.vscLightBlue, bg = "NONE" },
          ["@punctuation.special"] = { fg = c.vscYellow, bg = "NONE" },
        },
      })
      vim.cmd("colorscheme vscode")
    end,
  },
  -- Allows git links for lines and selections
  {
    "ruifm/gitlinker.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "ojroques/nvim-osc52" },
    config = function()
      require("gitlinker").setup({
        opts = {
          action_callback = function(url)
            -- yank to unnamed register
            vim.api.nvim_command("let @\" = '" .. url .. "'")
            -- copy to the system clipboard using OSC52
            require("osc52").copy_register("")
          end,
        },
      })
    end,
  },
  -- Allows vim to feel losing and gaining focus from tmux
  { "sjl/vitality.vim" },
  -- Pounce allows to quickly jump to fuzzy place on visible screen
  {
    "rlane/pounce.nvim",
    dependencies = { "Mofiqul/vscode.nvim" }, -- Uses colors from the palette.
  },
  -- Helm gotpl+yaml highlighter, see also `on_attach` for `yamlls`
  {
    "towolf/vim-helm",
    ft = "helm",
    lazy = false,
  },
  -- For yanking from terminal, see
  {
    "ojroques/nvim-osc52",
    lazy = false,
    config = function()
      require("osc52").setup({
        max_length = 0, -- Maximum length of selection (0 for no limit)
        silent = false, -- Disable message on successful copy
        trim = false,   -- Trim surrounding whitespaces before copy
        -- tmux_passthrough = true, -- Use tmux passthrough (requires tmux: set -g allow-passthrough on)
      })
      local function copy()
        if (vim.v.event.operator == "y" or vim.v.event.operator == "d") and vim.v.event.regname == "" then
          require("osc52").copy_register("")
        end
      end

      vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
    end,
  },
  -- Allowing seamless navigation btw tmux and vim
  { "christoomey/vim-tmux-navigator" },
  -- Markdown renderer
  -- CAVEAT: might need `yarn` to be installed. Might need to manually go to the directory
  -- `~/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim/` and run `yarn install`
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_port = "8000"
      vim.g.mkdp_browser = ""
      vim.g.mkdp_browserfunc = ""
      vim.g.mkdp_echo_preview_url = 1

      vim.keymap.set(
        "n",
        "<leader>lv",
        "<Plug>MarkdownPreviewToggle",
        { noremap = true, desc = "Toggle markdown preview" }
      )
    end,
    ft = { "markdown" },
  },
  -- Markdown TOC generator by :TOC
  {
    "mzlogin/vim-markdown-toc",
    config = function()
      -- https://github.com/mzlogin/vim-markdown-toc#options
      vim.g.vmt_fence_text = "TOC"
      vim.g.vmt_fence_closing_text = "/TOC"
      vim.g.vmt_fence_hidden_markdown_style = "GFM"

      vim.keymap.set(
        "n",
        "<leader>lv",
        "<Plug>MarkdownPreviewToggle",
        { noremap = true, desc = "Toggle markdown preview" }
      )
    end,
    ft = { "markdown" },
  },
  -- Allows to preview in floating window
  {
    "rmagatti/goto-preview",
    lazy = false,
    config = function()
      require("goto-preview").setup({})
      vim.keymap.set(
        "n",
        "gf",
        "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
        { noremap = true, desc = "Open preview in a float window" }
      )
    end,
  },
  -- Hop allows to quickly jump ti different places in the screen
  {
    "phaazon/hop.nvim",
    config = function()
      require("hop").setup({})
    end,
  },
  {
    "lervag/vimtex",
    event = "BufRead",
    config = function()
      -- A lot of important info is here https://dr563105.github.io/blog/skim-vimtex-setup/
      -- and here https://znculee.github.io/blogs/tools/vim#vimtex
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_view_method = "skim"
      -- Value 1 allows forward search after every successful compilation
      vim.g.vimtex_view_skim_sync = 1
      -- Value 1 allows change focus to skim after command `:VimtexView` is given
      vim.g.vimtex_view_skim_activate = 1
    end,
  },

  -- Commented out because it interferes with the `.vscode/launch.json` files.
  -- {
  --   "leoluz/nvim-dap-go",
  --   lazy = false,
  --   config = function()
  --     require("dap-go").setup {}
  --   end,
  -- },

  -- Useful for :TSHighlightUnderCursor to inspect treesitter highlight groups.
  {
    "nvim-treesitter/playground",
    lazy = false,
    enabled = true,
  },
  -- Seems that editorconfig in nvim 0.8 is not picked up, and `guess-indent.nvim`
  -- gets messed up with it,
  -- see https://github.com/NMAC427/guess-indent.nvim/issues/15#issuecomment-1586308382
  {
    "gpanders/editorconfig.nvim",
    lazy = false,
  },
  -- Bazel integration for neovim
  -- requires `pip install pynvim on the main system python`
  {
    "alexander-born/bazel.nvim",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- Bookmarks manipulation
  {
    "MattesGroeger/vim-bookmarks",
    lazy = false,
  },
  -- Telescope picker for bookmarks
  {
    "reaz1995/telescope-vim-bookmarks.nvim",
    lazy = false,
    dependencies = { "MattesGroeger/vim-bookmarks" },
  },
  -- This is a better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      preview = {
        win_height = 999,
        winblend = 0,
      },
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    opts = {
      ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
      ignored_buftypes = { "nofile" },
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = function(_, opts)
      local custom_opts = {
        default_source = "filesystem",
        source_selector = {
          winbar = true,
          content_layout = "center",
          sources = {                    -- table
            {
              source = "filesystem",     -- string
              display_name = "  Files " -- string | nil
            },
          },
        },
        window = {
          position = "right",
          width = 55,
          mappings = {
            ["<S-h>"] = "prev_source",
            ["<S-l>"] = "next_source",
          },
        },
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = true,
          },
        },
        event_handlers = {
          {
            -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#auto-close-on-open-file
            event = "file_opened",
            handler = function(_) -- argument is `file_path`
              --auto close
              require("neo-tree").close_all()
            end
          },
        },
      }
      return vim.tbl_deep_extend("force", opts, custom_opts)
    end,
    config = function(_, opts)
      require("neo-tree").setup(opts)
      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle explorer" })
      vim.keymap.set("n", "<leader>o", function()
          if vim.bo.filetype == "neo-tree" then
            vim.cmd.wincmd "p"
          else
            vim.cmd.Neotree "focus"
          end
        end,
        { desc = "Toggle Explorer Focus" })
    end
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
}

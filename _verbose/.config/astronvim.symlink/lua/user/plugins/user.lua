return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },
  -- You can also add new plugins here as well:
  -- customize alpha options
  {
    "goolord/alpha-nvim",
  },
  {
    "Mofiqul/vscode.nvim",
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
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "night",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day",    -- The theme is used when the background is set to light
        transparent = true,     -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark",              -- style for sidebars, see below
          floats = "dark",                -- style for floating windows
        },
        sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = true,              -- dims inactive windows
        lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold
        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors
        on_colors = function(colors)
        end,
        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights
        ---@param colors
        on_highlights = function(highlights, colors)
        end,
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      -- Default options:
      require("kanagawa").setup({
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = false },
        functionStyle = {},
        keywordStyle = { italic = false, bold = false },
        statementStyle = { bold = false },
        typeStyle = {},
        transparent = true,    -- do not set background color
        dimInactive = true,    -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {
          -- add/modify theme and palette colors
          palette = {},
          theme = {
            wave = {
              ui = {
                bg = "none",
                bg_dim = "none",
                bg_gutter = "none",
                float = {
                  bg_border = "none",
                },
              },
            },
            lotus = {},
            dragon = {},
            all = {},
          },
        },
        overrides = function(colors)
          return {
            -- Assign a static color to strings
            WinSeparator = { fg = colors.palette.sumiInk6 },
          }
        end,
        theme = "wave", -- Load "wave" theme when 'background' option is not set
      })
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          -- Compiled file's destination location
          transparent = true,   -- Disable setting background
          dim_inactive = false, -- Non focused panes set to alternative background
          styles = {
            -- Style to be applied to different syntax groups
            comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
          },
          inverse = {
            -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
          },
          modules = { -- List of various plugins and additional options
            -- ...
          },
        },
      })
    end,
  },
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

  -- Obsidian plugins
  {
    "epwalsh/obsidian.nvim",
    tag = "*", -- recommended, use latest release instead of latest commit
    requires = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufNewFile "
      .. vim.fn.expand("~")
      .. "/obsidian-main/**.md",
      "BufReadPre " .. vim.fn.expand("~") .. "/obsidian-main/**.md",
    },
    config = function()
      -- Configuration available here https://github.com/epwalsh/obsidian.nvim#configuration-options
      require("obsidian").setup({
        workspaces = {
          {
            name = "Main",
            path = "~/obsidian-main/Main",
          },
        },
        -- Optional, alternatively you can customize the frontmatter data.
        note_frontmatter_func = function(note)
          -- This is equivalent to the default frontmatter function.
          local out = { tags = note.tags }
          -- `note.metadata` contains any manually added fields in the frontmatter.
          -- So here we just make sure those fields are kept in the frontmatter.
          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
              out[k] = v
            end
          end
          return out
        end,
        -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
        completion = {
          -- Set to false to disable completion.
          nvim_cmp = false,
        },
      })
    end,
  },
  {
    "oflisback/obsidian-bridge.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("obsidian-bridge").setup()
    end,
    event = {
      "BufNewFile " .. vim.fn.expand("~") .. "/obsidian-main/**.md",
      "BufReadPre " .. vim.fn.expand("~") .. "/obsidian-main/**.md",
    },
    lazy = true,
  },
}

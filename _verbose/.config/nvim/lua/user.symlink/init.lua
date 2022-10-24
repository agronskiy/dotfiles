--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

local telescope_actions = require "telescope.actions"

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_reload = false, -- automatically reload and sync packer after a successful update
    auto_quit = false, -- automatically quit the current session after a successful update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme to use
  colorscheme = "vscode",

  -- Add highlight groups in any theme
  highlights = {
    -- init = { -- this table overrides highlights in all themes
    --   Normal = { bg = "#000000" },
    -- }
    -- duskfox = { -- a table of overrides/changes to the duskfox theme
    --   Normal = { bg = "#000000" },
    -- },
  },

  -- set vim options here (vim.<first_key>.<second_key> =  value)

  -- vim.opt.backup = false                          -- creates a backup file
  -- vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
  -- vim.opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages
  -- vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
  -- vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
  -- vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
  -- vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
  -- vim.opt.ignorecase = true                       -- ignore case in search patterns
  -- vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
  -- vim.opt.pumheight = 10                          -- pop up menu height
  -- vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
  -- vim.opt.showtabline = 0                         -- always show tabs
  -- vim.opt.smartcase = true                        -- smart case
  -- vim.opt.smartindent = true                      -- make indenting smarter again
  -- vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
  -- vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
  -- vim.opt.swapfile = false                        -- creates a swapfile
  -- vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
  -- vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
  -- vim.opt.undofile = true                         -- enable persistent undo
  -- vim.opt.updatetime = 300                        -- faster completion (4000ms default)
  -- vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  -- vim.opt.expandtab = true                        -- convert tabs to spaces
  -- vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
  -- vim.opt.tabstop = 2                             -- insert 2 spaces for a tab
  -- vim.opt.cursorline = true                       -- highlight the current line
  -- vim.opt.number = true                           -- set numbered lines
  -- vim.opt.laststatus = 3                          -- only the last window will always have a status line
  -- vim.opt.showcmd = false                         -- hide (partial) command in the last line of the screen (for performance)
  -- vim.opt.ruler = false                           -- hide the line and column number of the cursor position
  -- vim.opt.numberwidth = 4                         -- minimal number of columns to use for the line number {default 4}
  -- vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
  -- vim.opt.wrap = false                            -- display lines as one long line
  -- vim.opt.scrolloff = 8                           -- minimal number of screen lines to keep above and below the cursor
  -- vim.opt.sidescrolloff = 8                       -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
  -- vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
  -- vim.opt.fillchars.eob=" "                       -- show empty lines at the end of a buffer as ` ` {default `~`}
  -- vim.opt.shortmess:append "c"                    -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
  -- vim.opt.whichwrap:append("<,>,[,],h,l")         -- keys allowed to move to the previous/next line when the beginning/end of line is reached
  -- vim.opt.iskeyword:append("-")                   -- treats words with `-` as single words
  options = {
    opt = {
      -- set to true or false etc.
      autoindent = false,
      relativenumber = true, -- sets vim.opt.relativenumber
      cmdheight = 2,
      shiftwidth = 2,
      tabstop = 2,
      number = true, -- sets vim.opt.number
      spell = false, -- sets vim.opt.spell
      signcolumn = "auto", -- sets vim.opt.signcolumn to auto
      wrap = true, -- sets vim.opt.wrap
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true, -- enable completion at start
      autopairs_enabled = true, -- enable autopairs at start
      diagnostics_enabled = true, -- enable diagnostics at start
      status_diagnostics_enabled = true, -- enable diagnostics in statusline
      icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    },
  },

  rules = {
    cpp = { tabstop = 2, softtabstop = 2, shiftwidth = 2 },
    python = { tabstop = 4, softtabstop = 4, shiftwidth = 4 },
  },
  -- If you need more control, you can use the function()...end notation
  -- options = function(local_vim)
  --   local_vim.opt.relativenumber = true
  --   local_vim.g.mapleader = " "
  --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
  --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
  --
  --   return local_vim
  -- end,

  -- Set dashboard header
  header = {
  },

  -- Default theme configuration
  default_theme = {
    -- Modify the color palette for the default theme
    colors = {
      fg = "#abb2bf",
      bg = "#1e222a",
    },
    highlights = function(hl) -- or a function that returns a new table of colors to set
      local C = require "default_theme.colors"

      hl.Normal = { fg = C.fg, bg = C.bg }

      -- New approach instead of diagnostic_style
      hl.DiagnosticError.italic = true
      hl.DiagnosticHint.italic = true
      hl.DiagnosticInfo.italic = true
      hl.DiagnosticWarn.italic = true

      return hl
    end,
    -- enable or disable highlighting for extra plugins
    plugins = {
      aerial = true,
      beacon = false,
      bufferline = true,
      cmp = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      treesitter = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        disable_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the global LSP on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the mason server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
      pyright = {
        settings = {
          python = {
            -- See settings here https://github.com/microsoft/pyright/blob/main/docs/settings.md
            analysis = {
              typeCheckingMode = "off",
              autoSearchPaths = false,
              diagnosticMode = "openFilesOnly",
            },
          }
        },
      },
    },
  },

  -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      -- mappings seen under group name "Buffer"
      ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
      [";"] = ":",
      ["<leader>fs"] = { function() require("telescope.builtin").current_buffer_fuzzy_find() end,
        desc = "Search current buffer" },
      ["<leader>fc"] = { function() require("telescope.builtin").commands() end, desc = "Search commands" },
      ["<leader>fh"] = { function() require("telescope.builtin").command_history() end, desc = "Search command history" },
      -- quick save
      -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
      -- navigating wrapped lines
      j = { "gj", desc = "Navigate down" },
      k = { "gk", desc = "Navigate down" },
    },
    v = {
      -- navigating wrapped lines
      j = { "gj", desc = "Navigate down" },
      k = { "gk", desc = "Navigate down" },
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
  },

  -- Configure plugins
  plugins = {
    init = {
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },
      ["Darazaki/indent-o-matic"] = { disable = true },

      -- You can also add new plugins here as well:
      { "Mofiqul/vscode.nvim" },
      { "lervag/vimtex",
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

      -- Add plugins, the packer syntax without the "use"
      -- { "andweeb/presence.nvim" },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },

      -- We also support a key value style plugin definition similar to NvChad:
      -- ["ray-x/lsp_signature.nvim"] = {
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
    },

    -- All other entries override the require("<key>").setup({...}) call for default plugins
    ["null-ls"] = function(defaults)
      local null_ls = require("null-ls")
      defaults.sources = {
        -- bash
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.shellcheck,

        -- python
        -- null_ls.builtins.diagnostics.flake8,
        -- null_ls.builtins.diagnostics.pyproject_flake8,
        null_ls.builtins.diagnostics.mypy,
        -- null_ls.builtins.diagnostics.pycodestyle,
        -- null_ls.builtins.diagnostics.pydocstyle,
        -- null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
      }

      return defaults
    end,

    treesitter = { -- overrides `require("treesitter").setup(...)`
      -- ensure_installed = { "lua" },
    },

    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
      ensure_installed = { "sumneko_lua", "clangd", "pyright" },
    },

    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
      -- ensure_installed = { "prettier", "stylua" },
    },

    ["neo-tree"] = {
      window = {
        position = "right",
        width = 55,
      }
    },

    -- Telescope options
    telescope = {
      pickers = {
        live_grep = {
          mappings = {
            i = { ["<c-f>"] = telescope_actions.to_fuzzy_refine },
          },
        },
      }
    },

    toggleterm = {
      size = 100,
      direction = "vertical",
    },
  },


  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      -- javascript = { "javascriptreact" },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Modify which-key registration (Use this with mappings table in the above.)
  ["which-key"] = {
    -- Add bindings which show up as group name
    register = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- third key is the key to bring up next level and its displayed
          -- group name in which-key top level menu
          ["b"] = { name = "Buffer" },
        },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }

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
        end
      end,
    })
  end,
}

return config

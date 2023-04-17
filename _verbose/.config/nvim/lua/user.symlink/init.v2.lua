-- All configuration changes should go inside of the table below

-- Colors are synced with tmux.conf (`window-style`, `window-active-style`, `pane-border-style` etc)
local activeBgColor = "#1c1c1c"

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main",       -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_reload = false,   -- automatically reload and sync packer after a successful update
    auto_quit = false,     -- automatically quit the current session after a successful update
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
    init = {
      -- this table overrides highlights in all themes
      PounceMatch = {
        underline = true,
        bold = true,
        bg = vim.api.nvim_get_hl_by_name("Normal", true).background,
        fg = "#FF00FF",
      },
      PounceGap = {
        underline = true,
        bold = false,
        bg = vim.api.nvim_get_hl_by_name("Normal", true).background,
        fg = "#FF00FF",
      },
      PounceAccept = {
        underline = true,
        bold = true,
        bg = vim.api.nvim_get_hl_by_name("Normal", true).background,
        fg = "#00FFFF",
      },
      -- `NC` are non-current. The color corresponds to my unfocused color for
      -- e.g. tmux panes etc.
      -- NormalNC = {
      --   bg = inactiveBgColor,
      -- },
      -- WinBarNC = {
      --   bg = inactiveBgColor,
      -- },
      -- NormalFloat = { -- overrides the floating windows
      --   bg = activeBgColor,
      -- },
      -- TelescopeBorder = {
      --   bg = activeBgColor,
      -- },
      -- TelescopeNormal = {
      --   bg = activeBgColor,
      -- },
      -- TelescopePromptBorder = {
      --   bg = activeBgColor,
      -- },
      -- TelescopePromptNormal = {
      --   bg = activeBgColor,
      -- },
      -- TelescopeResultsBorder = {
      --   bg = activeBgColor,
      -- },
      -- TelescopeResultsNormal = {
      --   bg = activeBgColor,
      -- },
      -- TelescopePreviewBorder = {
      --   bg = activeBgColor,
      -- },
      -- TelescopePreviewNormal = {
      --   bg = activeBgColor,
      -- },
    }
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

  -- If you need more control, you can use the function()...end notation
  -- options = function(local_vim)
  --   local_vim.opt.relativenumber = true
  --   local_vim.g.mapleader = " "
  --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
  --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
  --
  --   return local_vim
  -- end,
  options = {
    opt = {
      -- set to true or false etc.
      autoindent = false,
      relativenumber = false, -- sets vim.opt.relativenumber
      cmdheight = 2,
      colorcolumn = { 80, 100, 120 },
      -- textwidth = 100,
      shiftwidth = 2,
      tabstop = 2,
      number = true,       -- sets vim.opt.number
      spell = false,       -- sets vim.opt.spell
      signcolumn = "auto", -- sets vim.opt.signcolumn to auto
      wrap = true,         -- sets vim.opt.wrap
      linebreak = true,
      mouse = "a",
    },
    g = {
      mapleader = " ",                   -- sets vim.g.mapleader
      autoformat_enabled = true,         -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true,                -- enable completion at start
      autopairs_enabled = true,          -- enable autopairs at start
      diagnostics_enabled = true,        -- enable diagnostics at start
      status_diagnostics_enabled = true, -- enable diagnostics in statusline
      icons_enabled = true,              -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    },
  },
  rules = {
    cpp = { tabstop = 2, softtabstop = 2, shiftwidth = 2 },
    python = { tabstop = 4, softtabstop = 4, shiftwidth = 4 },
    lua = { tabstop = 4, softtabstop = 4, shiftwidth = 4 },
  },
  -- Set dashboard header
  header = {},
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
      -- "snykls"
      -- "pyright"
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true,       -- enable or disable format on save globally
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
      yamlls = {
        -- override table for require("lspconfig").yamlls.setup({...})
        on_attach = function(_, bufnr)
          if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
            vim.diagnostic.disable(bufnr)
            vim.defer_fn(function()
              vim.diagnostic.reset(nil, bufnr)
            end, 1000)
          end
        end,
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/chart.json"] = "templates/*",
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              -- ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
            },
          },
        },
      },

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
      ["<leader>bo"] = { "<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>", desc = "Close other tabs" },
      ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
      [";"] = ":",
      ["<leader>fs"] = { function()
        require("telescope.builtin").current_buffer_fuzzy_find({
          layout_strategy = "horizontal",
        })
      end,
        desc = "Search current buffer" },
      ["<leader>fc"] = { function() require("telescope.builtin").commands() end, desc = "Search commands" },
      ["<leader>fh"] = { function() require("telescope.builtin").command_history() end, desc = "Search command history" },
      ["<leader>fm"] = { function()
        require("telescope.builtin").live_grep({
          additional_args = function()
            return { "--multiline", "--multiline-dotall" }
          end
        })
      end, desc = "Search multiline" },
      -- Opens preview in the split on the right.
      ["gp"] = { "<cmd>vert winc ]<cr>", desc = "Open preview in split" },
      -- Hop command to quickly go to uni/bi-graom
      ["w"] = { function() require("hop").hint_words() end, desc = "Hop to word" },
      ["t"] = { function() require("hop").hint_char1() end, desc = "Hop to char" },
      ["f"] = { function() require("pounce").pounce() end, desc = "Fuzzy hop with pounce" },
      -- quick save
      -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
      -- navigating wrapped lines
      j = { "gj", desc = "Navigate down" },
      k = { "gk", desc = "Navigate down" },
      ["gf"] = false, -- Disable `go to file under cursor`
      ["<leader>F"] = {
        -- `F` for `Focus`: it move to the leftmost split and leaves only it, closing all the other
        -- buffer. Useful for a round of exploration in the code.
        function()
          for _ = 1, 7 do
            vim.cmd("wincmd h")
          end
          vim.cmd("BufferLineCloseLeft")
          vim.cmd("BufferLineCloseRight")
          vim.cmd("only")
        end,
        desc = "Close other tabs and windows" },
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
      ["w"] = { function() require("hop").hint_words() end, desc = "Hop to word" },
      ["t"] = { function() require("hop").hint_char1() end, desc = "Hop to char" },
      ["f"] = { function() require("pounce").pounce() end, desc = "Fuzzy hop with pounce" },
      ["<leader>c"] = { ":'<,'>OSCYank<CR>", desc = "Yank to OSC52 clipboard", noremap = true },
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
      ["Mofiqul/vscode.nvim"] = {
        config = function()
          require("vscode").setup {
            transparent = true,
          }
        end,
      },
      -- Pounce allows to quickly jump to fuzzy place on visible screen
      ["rlane/pounce.nvim"] = {},
      -- Helm gotpl+yaml highlighter, see also `on_attach` for `yamlls`
      ["towolf/vim-helm"] = { ft = "helm" },
      -- For yanking from terminal, see
      ["ojroques/vim-oscyank"] = {
        config = function()
          -- Should be accompanied by a setting clipboard in tmux.conf, also see
          -- https://github.com/ojroques/vim-oscyank#the-plugin-does-not-work-with-tmux
          vim.g.oscyank_term = "default"
          vim.g.oscyank_max_length = 0
          -- Below autocmd is for copying to OSC52 for any yank operation,
          -- see https://github.com/ojroques/vim-oscyank#copying-from-a-register
          vim.api.nvim_create_autocmd("TextYankPost", {
            pattern = "*",
            callback = function()
              if vim.v.event.operator == "y" and vim.v.event.regname == "" then
                vim.cmd('OSCYankRegister "')
              end
            end,
          })
        end,
      },
      -- Allowing seamless navigation btw tmux and vim
      ["christoomey/vim-tmux-navigator"] = {},
      -- Markdown renderer
      -- CAVEAT: might need `yarn` to be installed. Might need to manually go to the directory
      -- `~/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim/` and run `yarn install`
      ["iamcco/markdown-preview.nvim"] = {
        run = function()
          vim.fn["mkdp#util#install"]()
        end,
        setup = function()
          vim.g.mkdp_filetypes = { "markdown" }
          vim.g.mkdp_port = "8000"
          vim.g.mkdp_browser = ""
          vim.g.mkdp_browserfunc = ""
          vim.g.mkdp_echo_preview_url = 1
        end,
        ft = { "markdown" }
      },
      -- Allows to preview in floating window
      ["rmagatti/goto-preview"] = {
        config = function()
          require("goto-preview").setup {}
          vim.keymap.set("n", "gf", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
            { noremap = true, desc = "Open preview in a float window" })
        end
      },
      -- Hop allows to quickly jump ti different places in the screen
      ["phaazon/hop.nvim"] = {
        config = function()
          require("hop").setup {}
        end,
      },
      ["lervag/vimtex"] = {
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
      ["sindrets/diffview.nvim"] = {},
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
        null_ls.builtins.formatting.latexindent,
        -- bazel, also see `polish` below for `filetypes`
        null_ls.builtins.diagnostics.buildifier,
      }

      return defaults
    end,
    treesitter = {
      -- overrides `require("treesitter").setup(...)`
      ensure_installed = {
        "bash", "cpp", "css", "html", "json", "lua", "python", "vim", "markdown_inline", "markdown",
      },
      highlight = {
        -- `false` will disable the whole extension
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
      },
    },
    bufferline = {
      options = {
        close_command = "bdelete %d",
        tab_size = 25,
        max_name_length = 25,
        separator_style = { "", "" },
      },
    },
    ["better_escape"] = {
      mapping = { "jk" },
    },
    gitsigns = {
      current_line_blame = true,
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
      ensure_installed = {
        "sumneko_lua",
        "clangd",
        "pyright",
        "rust_analyzer",
      },
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
      ensure_installed = {
        "buildifier",
      },
    },
    ["neo-tree"] = {
      window = {
        position = "right",
        width = 55,
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
    },
    -- Telescope options
    telescope = function(default_table)
      local actions = require("telescope.actions")
      local layout_actions = require("telescope.actions.layout")
      local common_settings = {
        w = 0.95,
        h = 0.9,
        vert_lines_cutoff = 20,
      }
      local custom_opts = {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            width = common_settings.h,
            height = common_settings.h,
            vertical = {
              mirror = true,
              prompt_position = "top",
              preview_cutoff = common_settings.vert_lines_cutoff,
              -- :h telescope.resolve
              preview_height = function(_, _, max_lines)
                -- Logic: keep preview dynamically changing in order to fix results
                -- height fixed
                if max_lines < common_settings.vert_lines_cutoff then
                  return math.ceil(max_lines * common_settings.h) - 6
                end
                return math.ceil(max_lines * common_settings.h) - 12
              end,
            }
          },
          mappings = {
            i = {
              ["jk"] = actions.close,
              ["<C-i>"] = layout_actions.toggle_preview,
              ["<C-f>"] = actions.to_fuzzy_refine,
              ["jl"] = false,
              ["jj"] = false,
            },
            n = {
              ["<C-i>"] = layout_actions.toggle_preview,
            },
          }
        },
        pickers = {
          find_files = {
            preview = {
              hide_on_startup = true, -- long paths friendly
            }
          },
          oldfiles = {
            preview = {
              hide_on_startup = true, -- long paths friendly
            }
          },
          lsp_references = {
            fname_width = 60,
          },
          lsp_document_symbols = {
            fname_width = 60,
            symbol_width = 35,
          },
          lsp_workspace_symbols = {
            fname_width = 60,
            symbol_width = 35,
          },
        },
      }
      return vim.tbl_deep_extend("force", default_table, custom_opts)
    end,
    -- NOTE: couldn't make that work in the main config part.
    -- We need it to play well with  the transparent color of the `vscode` theme, see
    -- `transparent = true` above
    notify = {
      background_colour = activeBgColor,
    },
    -- Heirline options
    heirline = function(config)
      -- the first element of the default configuration table is the statusline
      config[1] = {
        -- set the fg/bg of the statusline
        hl = { fg = "fg", bg = "bg" },
        -- when adding the mode component, enable the mode text with padding to the left/right of it
        astronvim.status.component.mode { mode_text = { padding = { left = 1, right = 1 } } },
        -- add all the other components for the statusline
        astronvim.status.component.git_branch(),
        astronvim.status.component.file_info(),
        astronvim.status.component.git_diff(),
        astronvim.status.component.diagnostics(),
        astronvim.status.component.fill(),
        astronvim.status.component.macro_recording(),
        astronvim.status.component.fill(),
        astronvim.status.component.lsp(),
        astronvim.status.component.treesitter(),
        astronvim.status.component.nav(),
      }
      -- return the final configuration table
      return config
    end,
    -- toggelterms
    toggleterm = {
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "single",
        -- like `size`, width and height can be a number or function which is passed the current terminal
        width = function()
          return math.ceil(vim.o.columns * 0.87)
        end,
        height = function()
          return math.ceil(vim.o.lines * 0.85)
        end,
      },
    }
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

    -- BUILD files -> starlark type
    vim.filetype.add {
      pattern = {
        [".*BUILD.*"] = "bzl",
      }
    }

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
  end,
}

return config

return {
  -- NOTE: First, some plugins that don't require any configuration

  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",
  {
    "folke/neodev.nvim",
    opts = {},
    event = "VimEnter",
  },
  -- nvim-cmp handles the complesion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "alexander-born/cmp-bazel" },
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "ray-x/cmp-treesitter" },
      { "onsails/lspkind.nvim" },

    },
    event = { "CmdlineEnter", "InsertEnter" },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local function has_words_before()
        local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and
            vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end
      local border_opts = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:MyCmpFloatBorder,CursorLine:PmenuSel,Search:None",
      }
      cmp.setup({
        preselect = cmp.PreselectMode.None,
        sources = cmp.config.sources {
          { name = "nvim_lsp",               priority = 1000 },
          { name = "nvim_lua",               priority = 1000 },
          { name = "nvim_lsp_signature_help" },
          { name = "treesitter" },
          { name = "buffer",
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            },
            priority = 500 },
          { name = "path", priority = 250 },
        },
        duplicates = {
          nvim_lsp = 1,
          luasnip = 1,
          cmp_tabnine = 1,
          buffer = 1,
          path = 1,
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        -- view = {
        --   entries = { name = "custom", selection_order = "near_cursor" }
        -- },
        window = {
          completion = cmp.config.window.bordered(border_opts),
          documentation = cmp.config.window.bordered(border_opts),
        },
        formatting = {
          format = lspkind.cmp_format(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable,
          ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
          ["<CR>"] = cmp.mapping.confirm { select = false },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      })
      -- `:` cmdline setup
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
          ["<C-k>"] = cmp.mapping { c = cmp.mapping.select_prev_item() },
          ["<C-j>"] = cmp.mapping { c = cmp.mapping.select_next_item() },
          ["<Tab>"] = cmp.mapping { c = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end },
          ["<S-Tab>"] = cmp.mapping { c = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end },
        }),
        sources = cmp.config.sources(
          { { name = "path" } },
          { {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" }
            }
          } }),
        formatting = {
          fields = { "abbr" },
          format = lspkind.cmp_format(),
          expandable_indicator = false,
        },
      })
      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          {
            name = "buffer",
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            }
          }
        }
      })
    end

  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    event = "VeryLazy",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      {
        "rmagatti/goto-preview",
        opts = {
          height = 25,
          border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
          -- resizing_mappings = true,  -- This binds to buffer and thus remains with buffer
          -- after closing the window
          post_open_hook = function(bufnr, winnr)
            local bo = vim.bo[bufnr]
            vim.keymap.set("c", "vs",
              function()
                bo.buflisted = true
                vim.cmd("vsplit")
                require("goto-preview").close_all_win()
              end,
              { noremap = true, desc = "Open preview in a float window", buffer = bufnr }
            )
            vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = bufnr, nowait = true })

            -- Setting this window's highlight
            -- Here, we create a separate highlight namespace to make `goto-preview`
            -- floating window look dark (they will be activated in the hook)
            local c = require("vscode.colors").get_colors()
            local preview_namespace = vim.api.nvim_create_namespace("GotoPreviewCustom")
            vim.api.nvim_set_hl(preview_namespace, "NormalFloat", { bg = c.vscBack })
            vim.api.nvim_win_set_hl_ns(winnr, preview_namespace)
          end,
          post_close_hook = function(bufnr, winnr)
            vim.keymap.del("n", "q", { buffer = bufnr })
          end
        }
      },
      -- Autocompletion
      { "hrsh7th/nvim-cmp" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
    config = function()
      local lsp_zero = require("lsp-zero")
      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false })
        lsp_zero.buffer_autoformat(client, bufnr)
        -- Open preview in split
        -- Additional keymaps
        vim.keymap.set("n", "gp", "<cmd>vert winc ]<cr>", { desc = "Open preview in split" })
        vim.keymap.set("n", "gf", require("goto-preview").goto_preview_definition,
          { noremap = true, desc = "Open preview in a float window" })
      end)

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "gopls",
          "helm_ls",
          "lua_ls",
          "pyright",
          "rust_analyzer",
          "terraformls",
          "tsserver",
          "yamlls"
        },
        handlers = {
          lsp_zero.default_setup,
          pyright = function()
            require("lspconfig").pyright.setup({
              root_dir = vim.loop.cwd,
              flags = { debounce_text_changes = 300 },
              settings = {
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "openFilesOnly",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "basic",
                  },
                },
              },
            })
          end,
          clangd = function()
            require("lspconfig").clangd.setup {
              cmd = {
                "clangd",
                "--query-driver=*",
                "--malloc-trim",
                "-j=64",
                "--background-index",
                "--suggest-missing-includes",
              },
            }
          end,
          helm_ls = function()
            -- I want to avoid yamlls schema check
            require("lspconfig").helm_ls.setup({
              settings = {
                ["helm-ls"] = {
                  yamlls = {
                    enabled = false,
                  }
                }
              }
            })
          end
        }
      })
    end
  },
  {
    "max397574/better-escape.nvim",
    opts = {
      mapping = { "jk" },
    },
  },
  -- Useful plugin to show you pending keybinds.
  { "folke/which-key.nvim",       opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    enabled = vim.fn.executable "git" == 1,
    event = "User FileOpened",
    opts = {
      current_line_blame = true,
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Actions
        -- visual mode
        map("v", "<leader>gS", function()
          gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
        end, { desc = "stage git hunk" })
        map("v", "<leader>gR", function()
          gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
        end, { desc = "reset git hunk" })
        -- normal mode
        map("n", "<leader>gs", gs.stage_hunk, { desc = "git stage hunk" })
        map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
        map("n", "<leader>gp", gs.preview_hunk, { desc = "preview git hunk" })
        map("n", "<leader>gb", function()
          gs.blame_line { full = false }
        end, { desc = "git blame line" })
        map("n", "<leader>gd", gs.diffthis, { desc = "git diff against index" })
        map("n", "<leader>gD", function()
          gs.diffthis "~"
        end, { desc = "git diff against last commit" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
      end,
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VimEnter", -- Workaround: if do later, some highlights are not working
    opts = {
      indent = { char = "▏" },
      scope = { show_start = false, show_end = false },
      exclude = {
        buftypes = {
          "nofile",
          "terminal",
        },
        filetypes = {
          "help",
          "startify",
          "aerial",
          "alpha",
          "dashboard",
          "lazy",
          "neogitstatus",
          "NvimTree",
          "neo-tree",
          "Trouble",
        },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      { "jay-babu/mason-null-ls.nvim" },
    },
    event = "VeryLazy",
    opts = function(_, config)
      -- config variable is the default configuration table for the setup function call
      local null_ls = require "null-ls"

      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- bash
        -- python
        -- null_ls.builtins.diagnostics.flake8,
        -- null_ls.builtins.diagnostics.pyproject_flake8,
        -- null_ls.builtins.diagnostics.mypy,
        -- null_ls.builtins.diagnostics.pycodestyle,
        -- null_ls.builtins.diagnostics.pydocstyle,
        -- null_ls.builtins.diagnostics.pylint,
        -- null_ls.builtins.formatting.black,
        -- null_ls.builtins.formatting.isort,
        -- null_ls.builtins.formatting.latexindent,
        -- bazel, also see `polish` below for `filetypes`
        null_ls.builtins.diagnostics.buildifier,
        -- Set a formatter
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.buildifier,
      }
      return config -- return final config table
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = "User FileOpened",
    opts = {
      -- CAVEAT: to ensure some decent mypy is installed together with `mason`, typically
      -- under ~/.local/share/nvim/mason/{bin,packages}, add `mypy` here. However, if you need to use `mypy` installed
      -- into your venv (e.g. if it uses nontrivial plugins or specific verison), make sure you
      -- remove `mypy` from here.
      ensure_installed = { "buildifier" },
    },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
  },
  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    dependencies = {
      { "dokwork/lualine-ex" },
      { "nvim-lua/plenary.nvim" },
      { "WhoIsSethDaniel/lualine-lsp-progress.nvim" },
    },
    event = "VeryLazy",
    config = function(_, opts)
      local function encoding()
        local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
        return ret
      end
      -- fileformat: Don't display if &ff is unix.
      local function fileformat()
        local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
        return ret
      end
      local function ts_enabled()
        if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] == nil then
          return ""
        end
        return "⚡︎TS"
      end
      local function list_lsp_and_null_ls()
        local buf_clients = vim.lsp.get_active_clients { bufnr = vim.api.nvim_get_current_buf() }
        local null_ls_installed, null_ls = pcall(require, "null-ls")
        local buf_client_names = {}
        local seen = {}
        for _, client in pairs(buf_clients) do
          if client.name == "null-ls" then
            if null_ls_installed then
              for _, source in ipairs(null_ls.get_source({ filetype = vim.bo.filetype })) do
                if not seen[source.name] == true then
                  table.insert(buf_client_names, source.name)
                  seen[source.name] = true
                end
              end
            end
          else
            if not seen[client.name] then
              table.insert(buf_client_names, client.name)
              seen[client.name] = true
            end
          end
        end
        if buf_client_names == nil then
          return "no lsp"
        end
        return table.concat(buf_client_names, ", ")
      end

      local c = require("vscode.colors").get_colors()
      local custom_opts = {
        options = {
          icons_enabled = true,
          theme = {
            normal = {
              a = { fg = c.vscNone, bg = c.vscPopupHighlightBlue },
              b = { fg = c.vscNone, bg = c.vscLeftDark },
              c = { fg = c.vscNone, bg = c.vscCursorDarkDark },
            },
            visual = {
              a = { fg = c.vscBack, bg = c.vscOrange },
              b = { fg = c.vscNone, bg = c.vscLeftDark },
              c = { fg = c.vscNone, bg = c.vscCursorDarkDark },
            },
            inactive = {
              a = { fg = c.vscNone, bg = c.vscCursorDarkDark },
              b = { fg = c.vscNone, bg = c.vscCursorDarkDark },
            },
            replace = {
              a = { fg = c.vscNone, bg = c.vscDiffRedDark },
              b = { fg = c.vscNone, bg = c.vscLeftDark },
              c = { fg = c.vscNone, bg = c.vscCursorDarkDark },
            },
            insert = {
              a = { fg = c.vscNone, bg = c.vscDiffGreenLight },
              b = { fg = c.vscNone, bg = c.vscLeftDark },
              c = { fg = c.vscNone, bg = c.vscCursorDarkDark },
            },
          },
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 100,
          }
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            {
              "branch",
              color = { fg = c.vscPink, gui = "bold" }
            },
            { "diff" },
            { "diagnostics" },
          },
          lualine_c = {
            { "ex.relative_filename", max_length = -1, color = { fg = c.vscGray } },
            { fileformat },
            { encoding },
          },
          lualine_x = {
            {
              "lsp_progress",
              colors = {
                percentage = c.vscPink,
                title = c.vscPink,
                message = c.vscPink,
                spinner = c.vscPink,
                lsp_client_name = c.vscPink,
                use = true,
              },
              separators = {
                component = " ",
                progress = " | ",
                message = { pre = "(", post = ")" },
                percentage = { pre = "", post = "%% " },
                title = { pre = "", post = ": " },
                lsp_client_name = { pre = "[", post = "]" },
                spinner = { pre = "", post = "" },
              },
              -- never show status for this list of servers;
              -- can be useful if your LSP server does not emit
              -- status messages
              -- hide = { "null-ls", "pyright" },
              -- by default this is false. If set to true will
              -- only show the status of LSP servers attached
              -- to the currently active buffer
              only_show_attached = true,
              display_components = { "spinner", { "title", "percentage", "message" } },
              timer = {
                progress_enddelay = 500,
                spinner = 500,
                lsp_client_name_enddelay = 1000,
                attached_delay = 3000,
              },
              spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
              message = { initializing = "Initializing…", commenced = "In Progress", completed = "Completed" },
              max_message_length = 30,

            },
            { list_lsp_and_null_ls },
            {
              ts_enabled,
              color = { fg = c.vscGreen, gui = "bold" },
            },
          },
          lualine_y = { "progress" },
          lualine_z = { "location" }
        },
      }
      require("lualine").setup(vim.tbl_deep_extend("force", opts, custom_opts))
    end
  },
  {
    "numToStr/Comment.nvim",
    event = "User FileOpened",
    opts = {
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      toggler = {
        ---Line-comment keymap
        line = "<leader>/",
      },
      opleader = {
        ---Line-comment keymap
        line = "<leader>/",
      },
    }
  },
  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable "make" == 1, build = "make" },
      { "reaz1995/telescope-vim-bookmarks.nvim" },
    },
    cmd = "Telescope",
    opts = function()
      local actions = require "telescope.actions"
      local layout_actions = require("telescope.actions.layout")
      local common_settings = {
        w = 0.95,
        h = 0.9,
        vert_lines_cutoff = 20,
      }
      return {
        defaults = {
          git_worktrees = vim.g.git_worktrees,
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            preview_cutoff = 120,
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
              ["<F2>"] = layout_actions.toggle_preview,
              ["<C-f>"] = actions.to_fuzzy_refine,
              ["jl"] = false,
              ["jj"] = false,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
            n = { q = actions.close },
          },
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
            fname_width = 80,
          },
          lsp_document_symbols = {
            fname_width = 80,
            symbol_width = 35,
          },
          lsp_workspace_symbols = {
            fname_width = 80,
            symbol_width = 35,
          },
        },
      }
    end,
    config = function(_, opts)
      -- Enable telescope fzf native, if installed
      require("telescope").setup(opts)
      pcall(require("telescope").load_extension, "fzf") -- might be unavailable, hence pcall
    end,
  },
  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
      local setup_fn = function()
        require("nvim-treesitter.configs").setup {
          -- Add languages to be installed here that you want installed for treesitter
          ensure_installed = {
            "c",
            "cpp",
            "go",
            "lua",
            "python",
            "rust",
            "tsx",
            "javascript",
            "typescript",
            "vimdoc",
            "vim",
            "bash",
            "yaml"
          },

          -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
          auto_install = false,

          highlight = { enable = true },
          indent = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "<c-space>",
              node_incremental = "<c-space>",
              scope_incremental = "<c-s>",
              node_decremental = "<M-space>",
            },
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
              },
              goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
              },
              goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
              },
              goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
              },
            },
            swap = {
              enable = true,
              swap_next = {
                ["<leader>a"] = "@parameter.inner",
              },
              swap_previous = {
                ["<leader>A"] = "@parameter.inner",
              },
            },
          },
        }
      end
      vim.defer_fn(setup_fn, 0)
    end
  },
  {
    "akinsho/bufferline.nvim",
    event = "User FileOpened",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "famiu/bufdelete.nvim" },
      { "Mofiqul/vscode.nvim" },
    },
    config = function(_, opts)
      local c = require("vscode.colors").get_colors()
      local custom_opts = {
        highlights = {
          fill = {
            bg = c.vscGreen,
          },
          buffer_visible = {
            fg = c.vscFront,
          },
        },
        options = {
          max_name_length = 35,
          truncate_names = false,
          show_buffer_icons = true,
          show_buffer_close_icons = false,
        }
      }
      require("bufferline").setup(vim.tbl_deep_extend("force", opts, custom_opts))
    end
  },
  { "nvim-tree/nvim-web-devicons" },
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
    event = "User FileOpened",
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
    event = "User FileOpened",
    dependencies = { "Mofiqul/vscode.nvim" }, -- Uses colors from the palette.
  },
  -- Helm gotpl+yaml highlighter, see also `on_attach` for `yamlls`
  {
    "towolf/vim-helm",
    ft = "helm",
  },
  -- For yanking from terminal, see
  {
    "ojroques/nvim-osc52",
    event = "User FileOpened",
    config = function()
      require("osc52").setup({
        max_length = 0, -- Maximum length of selection (0 for no limit)
        silent = true,  -- Disable message on successful copy
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
  -- Allows to preview in floating window, loaded in `zero_lsp.on_attach`
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

      -- Create specific bindings for TeX
      local mytex_group = vim.api.nvim_create_augroup("mytex", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter", "FileType" }, {
        desc = "Bindings for LaTeX",
        group = mytex_group,
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
  },

  -- Useful for :TSHighlightUnderCursor to inspect treesitter highlight groups.
  {
    "nvim-treesitter/playground",
    cmd = "TSHighlightUnderCursor",
  },
  -- Bazel integration for neovim
  -- requires `pip install pynvim on the main system python`
  {
    "alexander-born/bazel.nvim",
    ft = { "bzl" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  -- Bookmarks manipulation
  {
    "MattesGroeger/vim-bookmarks",
  },
  -- Telescope picker for bookmarks
  {
    "reaz1995/telescope-vim-bookmarks.nvim",
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
    event = "WinEnter",
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
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer NeoTree (root dir)", remap = true },
      {
        "<leader>o",
        function()
          if vim.bo.filetype == "neo-tree" then
            vim.cmd.wincmd "p"
          else
            vim.cmd.Neotree "focus"
          end
        end
        ,
        desc = "Explorer NeoTree (toggle)",
        remap = true
      },
    },
    opts = {
      close_if_last_window = true,
      default_source = "filesystem",
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
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
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
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
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
  -- Seems that editorconfig in nvim 0.8 is not picked up, and `guess-indent.nvim`
  -- gets messed up with it,
  -- see https://github.com/NMAC427/guess-indent.nvim/issues/15#issuecomment-1586308382
  {
    "gpanders/editorconfig.nvim",
    event = "User FileOpened",
  },
  {
    "akinsho/toggleterm.nvim",
    event = "User FileOpened",
    opts = {
      border = "single",
      -- like `size`, width and height can be a number or function which is passed the current terminal
      width = function()
        return math.ceil(vim.o.columns * 0.87)
      end,
      height = function()
        return math.ceil(vim.o.lines * 0.85)
      end,
      direction = "float",
      float_opts = { border = "rounded" },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" })
      vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>",
        { desc = "ToggleTerm vert" })
      vim.keymap.set({ "n", "t" }, "<F7>", "<cmd>ToggleTerm<cr>", { desc = "ToggleTerm" })
    end
  },
  {
    "stevearc/conform.nvim",
    event = "User FileOpened",
    opts = {
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        bzl = { "buildifier" },
        tex = { "latexindent" },
      },
    },
  },
  {
    "RRethy/vim-illuminate",
    event = "User FileOpened",
    config = function(_, opts)
      require("illuminate").configure({})
    end,
  },
  -- LazyGit is nice for nontrivial git tasks
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>tl", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  -- shows colors
  {
    "norcalli/nvim-colorizer.lua",
    event = 'User FileOpened',
    opts = {}
  }
}

return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "vscode",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  rules = {
    cpp = { tabstop = 2, softtabstop = 2, shiftwidth = 2 },
    python = { tabstop = 4, softtabstop = 4, shiftwidth = 4 },
  },
  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true,     -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
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

    -- This uses systemwide python for plugins instead of the virtualenv one.
    -- https://github.com/neovim/neovim/issues/1887#issuecomment-280653872
    if os.getenv("VIRTUAL_ENV") then
      vim.g.python3_host_prog = vim.fn.substitute(vim.fn.system("which -a python3 | head -n2 | tail -n1"), "\n", "", "g")
    else
      vim.g.python3_host_prog = vim.fn.substitute(vim.fn.system("which python3"), "\n", "", "g")
    end

    -- BUILD files -> starlark type
    vim.filetype.add({
      pattern = {
        [".*BUILD.*"] = "bzl",
      },
    })

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


    -- Make and autocmd so that curr window loses focus when the whole vim
    -- loses focus.
    -- create an augroup to easily manage autocommands
    local auto_win_group = vim.api.nvim_create_augroup("autowinmanagement", { clear = true })
    local utils = require("astronvim.utils")
    NORMAL_BG = utils.get_hlgroup("Normal").bg
    NORMAL_NC_BG = utils.get_hlgroup("NormalNC").bg
    vim.api.nvim_create_autocmd({ "FocusLost" }, {
      desc = "Make currwindow look inactive", -- nice description
      group = auto_win_group,                 -- add the autocmd to the newly created augroup
      callback = function()
        vim.api.nvim_set_hl(0, "Normal", { bg = NORMAL_NC_BG })
        vim.api.nvim_set_hl(0, "WinBar", { bg = NORMAL_NC_BG })
      end,
    })
    vim.api.nvim_create_autocmd({ "FocusGained" }, {
      desc = "Make currwindow look active", -- nice description
      group = auto_win_group,               -- add the autocmd to the newly created augroup
      callback = function()
        vim.api.nvim_set_hl(0, "Normal", { bg = NORMAL_BG })
        vim.api.nvim_set_hl(0, "WinBar", { bg = NORMAL_BG })
      end,
    })

    -- Bazel keymaps, see https://github.com/alexander-born/bazel.nvim#vim-functions
    vim.api.nvim_create_autocmd(
      "FileType",
      {
        pattern = "bzl",
        callback = function()
          vim.keymap.set("n", "gd", vim.fn.GoToBazelDefinition,
            { buffer = true, desc = "Goto Bazel Definition" })
          vim.keymap.set("n", "gp", function()
              -- Create split then go to def
              -- https://www.reddit.com/r/neovim/comments/mbh7kp/lua_api_to_create_a_split_window/
              vim.cmd("vsplit")
              vim.fn.GoToBazelDefinition()
            end,
            { buffer = true, desc = "Goto Bazel Definition in split" })
        end,
      }
    )
  end,
}

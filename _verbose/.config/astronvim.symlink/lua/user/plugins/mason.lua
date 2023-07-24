-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "clangd",
        "pyright",
        "rust_analyzer",
        "lua_ls",
        "gopls",
        "tsserver",
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "buildifier",
        -- "prettier",
        -- "stylua",
      },
      -- ensure_installed = { "prettier", "stylua" },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = { "python", "codelldb" }, -- for `delve`, I use `nvim-dap-go`
      handlers = {
        -- 1. https://miguelcrespo.co/how-to-debug-like-a-pro-using-neovim
        -- 2. https://astronvim.com/Recipes/dap#installing-debuggers-with-mason
        -- 3. https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/README.md#advanced-customization
        --
        -- https://github.com/mfussenegger/nvim-dap/issues/20#issuecomment-1212214935 for dicts
        -- {
        --     "version": "0.2.0",
        --     "configurations": [
        --         {
        --             "type": "codelldb",
        --             "request": "launch",
        --             "name": "Debug",
        --             "program": "${fileDirname}/../target/debug/hello_cargo",
        --             "args": [],
        --             "sourceLanguages": [
        --                 "rust"
        --             ]
        --         }
        --     ]
        -- }
        -- codelldb = function(config)
        --   require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "rust", "cpp" } })
        --   require("mason-nvim-dap").default_setup(config)
        -- end,
      },
    },
  },
}

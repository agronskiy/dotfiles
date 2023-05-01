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
      ensure_installed = { "python", "codelldb" },
      handlers = {
        -- 1. https://miguelcrespo.co/how-to-debug-like-a-pro-using-neovim
        -- 2. https://astronvim.com/Recipes/dap#installing-debuggers-with-mason
        -- 3. https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/README.md#advanced-customization
        codelldb = function(config)
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
          require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "rust", "cpp" } })
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
}

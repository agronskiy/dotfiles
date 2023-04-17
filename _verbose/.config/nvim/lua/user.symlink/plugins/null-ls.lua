return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
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
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,
    }
    return config -- return final config table
  end,
}

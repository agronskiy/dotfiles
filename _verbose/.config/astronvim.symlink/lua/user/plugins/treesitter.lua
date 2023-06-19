return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- overrides `require("treesitter").setup(...)`
    ensure_installed = {
      -- latex and bibtex will be controlled by VimTeX plugin, don't set
      "bash",
      "cpp",
      "css",
      "dockerfile",
      "go",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "proto",
      "python",
      "starlark",
      "typescript",
      "vim",
      "yaml",
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
}

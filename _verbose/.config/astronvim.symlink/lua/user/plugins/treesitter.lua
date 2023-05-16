return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- overrides `require("treesitter").setup(...)`
    ensure_installed = {
      "bash", "cpp", "css", "html", "json", "lua", "python", "vim", "markdown_inline", "markdown",
      "javascript", "yaml",
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

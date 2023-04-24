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
  {
    "Mofiqul/vscode.nvim",
    config = function()
      require("vscode").setup {
        transparent = true,
      }
    end,
  },
  -- Pounce allows to quickly jump to fuzzy place on visible screen
  "rlane/pounce.nvim",
  -- Helm gotpl+yaml highlighter, see also `on_attach` for `yamlls`
  {
    "towolf/vim-helm",
    ft = "helm"
  },
  -- For yanking from terminal, see
  {
    "ojroques/vim-oscyank",
    lazy = false,
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
          if ((vim.v.event.operator == "y" or vim.v.event.operator == "d")
            and vim.v.event.regname == "") then
            vim.cmd('OSCYankRegister "')
          end
        end,
      })
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

      vim.keymap.set("n", "<leader>lv", "<Plug>MarkdownPreviewToggle",
        { noremap = true, desc = "Toggle markdown preview" })
    end,
    ft = { "markdown" }
  },
  -- Allows to preview in floating window
  {
    "rmagatti/goto-preview",
    lazy = false,
    config = function()
      require("goto-preview").setup {}
      vim.keymap.set("n", "gf", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
        { noremap = true, desc = "Open preview in a float window" })
    end
  },
  -- Hop allows to quickly jump ti different places in the screen
  {
    "phaazon/hop.nvim",
    config = function()
      require("hop").setup {}
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
}

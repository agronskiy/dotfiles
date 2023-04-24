return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    local custom_opts = {
      default_source = "filesystem",
      source_selector = {
        winbar = true,
        content_layout = "center",
        sources = {                    -- table
          {
            source = "filesystem",     -- string
            display_name = "  Files " -- string | nil
          },
          {
            source = "buffers",         -- string
            display_name = "  Buffers" -- string | nil
          },
          {
            source = "git_status",   -- string
            display_name = "  Git " -- string | nil
          },
        },
      },
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
    -- This is a small hack until AstroNvim updates the defaults for neo-tree, currently it contains
    -- an outdated `source_selector.tab_labels`, which generates a warning, so we forcefully delete it here.
    opts.source_selector.tab_labels = nil
    return vim.tbl_deep_extend("force", opts, custom_opts)
  end
}

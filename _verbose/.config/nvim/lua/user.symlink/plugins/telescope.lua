return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
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
    return vim.tbl_deep_extend("force", opts, custom_opts)
  end,
}

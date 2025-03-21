-- Various polishing
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

vim.filetype.add({
  extension = {
    ["jsonl"] = "json",
  },
})

-- AVRO to json
vim.filetype.add({
  extension = {
    ["avsc"] = "json",
    ["tfstate"] = "json",
    ["tf"] = "terraform",
    ["hcl"] = "terraform",
  },
})

-- `"pyrightconfig.json"` is actually jsonc
vim.filetype.add({
  filename = {
    ["pyrightconfig.json"] = "jsonc",
  },
})

-- try to source `.idea/nvim-filetypes` to add per-file
local function add_filetypes_from_config()
  -- Get the full path to the `.idea/nvim-filetypes` file with `filapath:filetype`
  local project_root = vim.fn.getcwd()
  local config_path = project_root .. "/.idea/nvim-filetypes"

  -- Check if the file exists
  if vim.fn.filereadable(config_path) == 1 then
    -- Read the file and build a filetype mapping table
    local filetype_mappings = {}

    for line in io.lines(config_path) do
      -- Split each line by colon
      local filepath, filetype = line:match("([^:]+):(.+)")
      if filepath and filetype then
        filetype_mappings[filepath] = filetype
      end
    end

    -- Add the mappings to Neovim's filetypes
    vim.filetype.add({
      pattern = filetype_mappings,
    })
  end
end

-- Run the function during Neovim startup
add_filetypes_from_config()


-- Experimental ability to switch to another lsp
vim.api.nvim_create_user_command('FT', function(opts)
  if opts.args and opts.args ~= '' then
    -- Set the filetype to the provided argument
    vim.bo.filetype = opts.args

    -- Restart LSP
    vim.cmd('LspRestart')

    print('Filetype set to ' .. opts.args .. ' and LSP restarted')
  else
    print('Usage: sft <filetype>')
  end
end, { nargs = 1, desc = 'Set filetype and restart LSP' })

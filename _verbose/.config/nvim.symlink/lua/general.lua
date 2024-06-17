-- document existing key chains
require("which-key").register {
  ["<leader>c"] = { name = "Code", _ = "which_key_ignore" },
  ["<leader>d"] = { name = "Document", _ = "which_key_ignore" },
  ["<leader>g"] = { name = "Git", _ = "which_key_ignore" },
  ["<leader>r"] = { name = "Rename", _ = "which_key_ignore" },
  ["<leader>f"] = { name = "Find", _ = "which_key_ignore" },
}

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

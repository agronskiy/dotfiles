-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

vim.o.breakindent = true                    -- wrap indent to match  line start
vim.o.clipboard = "unnamedplus"             -- connection to the system clipboard
vim.o.completeopt = "menu,menuone,noselect" -- Options for insert mode completion
vim.o.copyindent = true                     -- copy the previous indentation on autoindenting
vim.o.cursorline = true                     -- highlight the text line of the cursor
vim.o.expandtab = true                      -- enable the use of space in tab
-- vim.o.fileencoding = "utf-8"                -- file content encoding for the buffer
vim.o.foldenable = true                     -- enable fold for nvim-ufo
vim.o.foldlevel = 99                        -- set high foldlevel for nvim-ufo
vim.o.foldlevelstart = 99                   -- start with all code unfolded
vim.o.foldcolumn = vim.fn.has "nvim-0.9" == 1 and "1" or nil
vim.o.history = 100                         -- number of commands to remember in a history table
vim.o.ignorecase = true                     -- case insensitive searching
vim.o.infercase = true                      -- infer cases in keyword completion
-- vim.o.statuscolumn = "%l %s"
vim.o.linebreak = true                      -- wrap lines at 'breakat'
vim.o.mouse = "a"                           -- enable mouse support
vim.o.number = true                         -- show numberline
vim.o.numberwidth = 1
vim.o.preserveindent = false                -- preserve indent structure as much as possible
vim.o.pumheight = 10                        -- height of the pop up menu
vim.o.shiftwidth = 2                        -- number of space inserted for indentation
vim.o.showmode = false                      -- disable showing modes in command line
vim.o.smartcase = true                      -- case sensitive searching
vim.o.splitbelow = true                     -- splitting a new window below the current one
vim.o.splitright = true                     -- splitting a new window at the right of the current one
vim.o.tabstop = 2                           -- number of space in a tab
vim.o.termguicolors = true                  -- enable 24-bit RGB color in the TUI
vim.o.undofile = true                       -- enable persistent undo
vim.o.virtualedit = "block"                 -- allow going past end of line in visual block mode
vim.o.writebackup = false                   -- disable making a backup before overwriting a file
vim.o.autoindent = false
vim.o.cmdheight = 2
vim.o.colorcolumn = "80,100,120"
vim.o.spell = false      -- sets vim.opt.spell
vim.o.signcolumn = "yes" -- sets vim.opt.signcolumn to auto
vim.o.wrap = true        -- sets vim.opt.wrap


-- Set highlight on search
vim.o.hlsearch = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.g.editorconfig = true

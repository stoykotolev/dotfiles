vim.g.have_nerd_font = true
vim.o.termguicolors = true

-- Make line numbers default and show relative numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false          -- mode is already in status line
vim.opt.clipboard = 'unnamedplus' -- sync clipboard cuz yeah
vim.opt.breakindent = true        -- keep indent when linebreak
vim.opt.undofile = true           -- undo history

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes' -- sign column cuz we have them

vim.opt.updatetime = 250   -- Decrease update time
vim.opt.timeoutlen = 300   -- Decrease mapped sequence wait time

vim.opt.splitright = true  -- horizontal split to the right
vim.opt.splitbelow = true  -- vert split on the bottom

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split' -- preview text replace live
vim.opt.cursorline = true    -- indicate where the cursor is
vim.opt.scrolloff = 10       -- at least 10 lines above and below curr line
vim.opt.hlsearch = true      -- highlight on search

-- Folding
vim.opt.fillchars = { fold = " " }
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldlevel = 99

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local set = vim.opt
-- Options
vim.g.have_nerd_font = true
vim.o.termguicolors = true

-- Make line numbers default and show relative numbers
set.number = true
set.relativenumber = true
set.showmode = false          -- mode is already in status line
set.clipboard = 'unnamedplus' -- sync clipboard cuz yeah
set.breakindent = true        -- keep indent when linebreak
set.undofile = true           -- undo history

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
set.ignorecase = true
set.smartcase = true
set.signcolumn = 'yes' -- sign column cuz we have them

set.updatetime = 250   -- Decrease update time
set.timeoutlen = 300   -- Decrease mapped sequence wait time

set.splitright = true  -- horizontal split to the right
set.splitbelow = true  -- vert split on the bottom

-- Sets how neovim will display certain whitespace characters in the editor.
set.list = true
set.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

set.inccommand = 'split' -- preview text replace live
set.cursorline = true    -- indicate where the cursor is
set.scrolloff = 10       -- at least 10 lines above and below curr line
set.hlsearch = true      -- highlight on search

-- Folding
set.fillchars = { fold = " " }
set.foldmethod = "indent"
set.foldenable = false
set.foldlevel = 99

set.formatoptions:remove "o"


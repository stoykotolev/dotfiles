vim.g.mapleader = ' '
vim.g.have_nerd_font = true
vim.o.termguicolors = true

local set = vim.opt

set.number = true
set.relativenumber = true
set.showmode = false          -- mode is already in status line
set.clipboard = 'unnamedplus' -- sync clipboard cuz yeah
set.breakindent = true        -- keep indent when linebreak
set.undofile = true           -- undo history
set.ignorecase = true
set.smartcase = true
set.signcolumn = 'yes' -- sign column cuz we have them
set.updatetime = 250   -- Decrease update time
set.timeoutlen = 300   -- Decrease mapped sequence wait time
set.splitright = true  -- horizontal split to the right
set.splitbelow = true  -- vert split on the bottom
set.list = true
set.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
set.inccommand = 'split' -- preview text replace live
set.cursorline = true    -- indicate where the cursor is
set.scrolloff = 10       -- at least 10 lines above and below curr line
set.hlsearch = true      -- highlight on search
set.formatoptions:remove "o" -- making new line with "o" will not add the comment line syntax


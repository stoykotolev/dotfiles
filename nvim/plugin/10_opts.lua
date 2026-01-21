vim.g.mapleader = ' '
vim.g.have_nerd_font = true
vim.o.termguicolors = true

local set = vim.opt

set.number = true
set.relativenumber = true
set.showmode = false -- mode is already in status line
set.clipboard = 'unnamedplus' -- sync clipboard cuz yeah
set.breakindent = true -- keep indent when linebreak
set.undofile = true -- undo history
set.signcolumn = 'yes' -- sign column cuz we have them
set.updatetime = 250 -- Decrease update time
set.timeoutlen = 300 -- Decrease mapped sequence wait time
set.splitright = true -- horizontal split to the right
set.splitbelow = true -- vert split on the bottom
set.list = true
set.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
set.inccommand = 'split' -- preview text replace live
set.cursorline = true -- indicate where the cursor is
set.scrolloff = 10 -- at least 10 lines above and below curr line
set.hlsearch = true -- highlight on search
set.formatoptions:remove('o') -- making new line with "o" will not add the comment line syntax
set.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)
set.colorcolumn = '+1' -- Draw column on the right of maximum width
set.list = true
set.linebreak = true

-- Fold
set.foldlevel = 10 -- Fold nothing by default; set to 0 or 1 to fold
set.foldmethod = 'indent' -- Fold based on indent level
set.foldnestmax = 10 -- Limit number of fold levels
set.foldtext = '' -- Show text under fold with its highlighting

-- Editing
set.autoindent = true -- Use auto indent
set.expandtab = true -- Convert tabs to spaces
set.formatoptions = 'rqnl1j' -- Improve comment editing
set.ignorecase = true -- Ignore case during search
set.incsearch = true -- Show search matches while typing
set.infercase = true -- Infer case in built-in completion
set.shiftwidth = 2 -- Use this number of spaces for indentation
set.smartcase = true -- Respect case if search pattern has upper case
set.smartindent = true -- Make indenting smart
set.spelloptions = 'camel' -- Treat camelCase word parts as separate words
set.tabstop = 2 -- Show tab as this number of spaces
set.virtualedit = 'block' -- Allow going past end of line in blockwise mode
set.iskeyword = '@,48-57,_,192-255,-' -- Treat dash as `word` textobject part
set.complete = '.,w,b,kspell' -- Use less sources
set.completeopt = 'menuone,fuzzy,nosort' -- Use custom behavior

MiniDeps.later(function()
  vim.diagnostic.config({
    -- Show signs on top of any other sign, but only for warnings and errors
    signs = { priority = 9999, severity = { min = 'WARN', max = 'ERROR' } },

    underline = { severity = { min = 'HINT', max = 'ERROR' } },

    -- Show more details immediately for errors on the current line
    virtual_lines = false,
    virtual_text = {
      current_line = true,
      severity = { min = 'ERROR', max = 'ERROR' },
    },

    -- Don't update diagnostics when typing
    update_in_insert = false,
  })
end)

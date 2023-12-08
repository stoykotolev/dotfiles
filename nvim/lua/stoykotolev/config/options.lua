local opt = vim.opt

opt.shiftwidth = 2 -- insert 2 spaces when tabbing/ default is 8
opt.tabstop = 2 -- tabbing is 2 spaces / default is 8
opt.expandtab = true -- use tabs
opt.softtabstop = 2 -- control the above when deleting
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.termguicolors = true -- enable 2 bit RGB colors, most modern terminal emulators support this
opt.autoindent = true -- auto indent when using `o` or `O`
opt.smartindent = true -- smart indenting
opt.wrap = false -- wrap lines
vim.wo.number = true -- numbers
vim.wo.relativenumber = true -- relative numbers
opt.cmdheight = 1 -- height of command bar when using :
opt.fileencoding = 'utf-8' -- encoding of files
opt.ignorecase = true -- ignore case while searching
opt.smartcase = true -- ovveride ignore case if search pattern contains upper case characters
opt.numberwidth = 4 -- number column width
opt.pumheight = 10 -- height of pop up menu
opt.sidescrolloff = 8 -- minimum number of columns on the left and right of the cursor
opt.cursorline = false -- highlights the current line
opt.conceallevel = 0 -- to show text normally
opt.hlsearch = false -- highlight words when searching
opt.undofile = true -- persistent undo
opt.title = true -- set the window title to the current file
opt.showcmd = true -- show partially the command that is being ran
opt.laststatus = 2 -- always show the status bar
opt.scrolloff = 999 -- num of lines below / above the cursor before cutoff / 999 sets the cursor to always be in the middle of your screen
opt.shell = 'fish'
opt.whichwrap:append 'b,s,<,>,[,],h,l' -- allow for horizontal movement to go to next line
opt.clipboard = 'unnamedplus' -- sync clipboard with system clipboard
opt.swapfile = false -- creates swap file

-- backup configuration
opt.backup = false
opt.backupskip = '/tmp/*,/private/tmp/*'

opt.inccommand = 'split' -- show preview of results when replacing
opt.breakindent = true -- continue indentation for lines that are breaking keeping readibility
opt.backspace = 'start,eol,indent' -- allow backspace to work in insert mode
opt.shortmess:append 'c' -- see :help 'shortmess'

-- Undercurl
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

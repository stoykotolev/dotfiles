local opt = vim.opt

-- 2 spaces for each indentation
opt.shiftwidth = 2
-- insert 2 spaces for tab while editing
-- opt.tabstop = 2
opt.softtabstop = 2
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.termguicolors = true -- enable 2 bit RGB colors, most modern terminal emulators support this
opt.autoindent = true -- auto indent when using `o` or `O`
opt.smartindent = true -- smart indenting
opt.wrap = true -- wrap lines

-- enable number lines and relative numbers
vim.wo.number = true
vim.wo.relativenumber = true
opt.cmdheight = 4 -- height of command bar
opt.fileencoding = "utf-8" -- encoding of files
-- opt.mouse = "a" -- enable mouse in all modes / might disable this, don't know how I feel // Still not sure. Leaving it commented out for now
opt.ignorecase = true -- ignore case while searching
opt.smartcase = true -- ovveride ignore case if search pattern contains upper case characters
opt.numberwidth = 4 -- number column width
opt.pumheight = 10 -- height of pop up menu
opt.sidescrolloff = 8 -- minimum number of columns on the left and right of the cursor
opt.whichwrap:append "b,s,<,>,[,],h,l" -- allow for horizontal movement to go to next line
opt.clipboard = "unnamedplus" -- sync clipboard with system clipboard
opt.swapfile = false -- creates swap file
opt.cursorline = false -- highlights the current line
opt.conceallevel = 0 -- to show text normally
opt.hlsearch = false
opt.undofile = true -- persistent undo
opt.title = true -- set the window title to the current file
opt.showcmd = true -- show partially the command that is being ran
opt.cmdheight = 1 -- height of the command line in vim
opt.laststatus = 2 -- always show the status bar
opt.scrolloff = 10
opt.shell = "zsh"

-- backup configuration
opt.backup = false
opt.backupskip = "/tmp/*,/private/tmp/*"

opt.inccommand = "split" -- show preview of results when replacing
opt.breakindent = true -- continue indentation for lines that are breaking keeping readibility
opt.backspace = "start,eol,indent"
opt.path:append { "**" } -- Finding files - Search down into subfolders
opt.wildignore:append { "*/node_modules/*" } -- Ignore specific folder and file patterns

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

opt.formatoptions:append { "r" } -- handling of automatic formatting

local map = vim.keymap.set
local o = { silent = true }

-- set leader to space --
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   command_mode = "c",

-- move line up/down
map("n", "<leader>j", "ddp", o)
map("n", "<leader>k", "ddkP", o)


map('n', '+', '<C-a>')
map('n', '-', '<C-x>')


map('n', 'dw', 'vb"_d')
map('n', '<C-a>', 'gg<S-v>G')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')

-- tabs --
map('n', 'te', ':tabedit<Return>', o) -- opens a new tab
map('n', 'tc', ':tabclose<Return>', o) -- closes the tab but keeps it in the buffer

map('n', 'ss', ':split<Return><C-w>w')
map('n', 'sv', ':vsplit<Return><C-w>w')

map('n', '<Space>', '<C-w>w')
map('', 's<left>', '<C-w>h')
map('', 's<up>', '<C-w>k')
map('', 's<down>', '<C-w>j')
map('n', 'yw', 'yiw', o) -- yank a word from anywhere
map('', 's<right>', '<C-w>l')
map('', 'sh', '<C-w>h')
map('', 'sk', '<C-w>k')
map('', 'sj', '<C-w>j')
map('', 'sl', '<C-w>l')

map('n', '<C-w><left>', '<C-w><')
map('n', '<C-w><right>', '<C-w>>')
map('n', '<C-w><up>', '<C-w>+')
map('n', '<C-w><down>', '<C-w>-')

map('n', '<C-/>', ':s/^/#<CR>')

map('n', 'x', '"_x', o) -- Do not yank with x
map({ 'n', 'v', 'x' }, 'diw', '"_diw', o) -- delete word without yanking
map('n', 'cw', '"_ciw', o) -- change a word from anywhere without yanking
map('n', 'cc', '"_cc', o) -- change line without yanking
map('v', 'c', '"_c', o) -- change selection without yanking
map('v', 'p', '"_dP', o) -- override selected word without yanking it

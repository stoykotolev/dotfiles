local keymap = vim.keymap.set
local o = { silent = true }
vim.g.mapleader = " "

keymap('n', 'x', '"_x') -- Do not yank with x

keymap('n', '+', '<C-a>')
keymap('n', '-', '<C-x>')


keymap('n', 'dw', 'vb"_d')
keymap('n', '<C-a>', 'gg<S-v>G')
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')
keymap('n', 'n', 'nzz')
keymap('n', 'n', 'Nzz')

keymap('n', 'te', ':tabedit<Return>', { silent = true })
keymap('n', 'ss', ':split<Return><C-w>w', { silent = true })
keymap('n', 'sv', ':vsplit<Return><C-w>w', { silent = true })

keymap('n', '<Space>', '<C-w>w')
keymap('', 's<left>', '<C-w>h')
keymap('', 's<up>', '<C-w>k')
keymap('', 's<down>', '<C-w>j')
keymap('n', 'yw', 'yiw', o) -- yank a word from anywhere
keymap('', 's<right>', '<C-w>l')
keymap('', 'sh', '<C-w>h')
keymap('', 'sk', '<C-w>k')
keymap('', 'sj', '<C-w>j')
keymap('', 'sl', '<C-w>l')

keymap('n', '<C-w><left>', '<C-w><')
keymap('n', '<C-w><right>', '<C-w>>')
keymap('n', '<C-w><up>', '<C-w>+')
keymap('n', '<C-w><down>', '<C-w>-')

keymap('n', '<C-/>', ':s/^/#<CR>')

keymap('n', 'cw', '"_ciw', o) -- change a word from anywhere without yanking
keymap('n', 'cc', '"_cc', o) -- change line without yanking
keymap('v', 'c', '"_c', o) -- change selection without yanking
keymap('v', 'p', '"_dP', o) -- override selected word without yanking it

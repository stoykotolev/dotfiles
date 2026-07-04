-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set
local opts = { silent = true }

-- Standard remaps --
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<C-a>', 'gg<S-v>G')
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)
map('n', 'n', 'nzz', opts)
map('n', 'N', 'Nzz', opts)
map('n', 'yw', 'yiw', opts)
map('n', 'x', '"_x', opts)
map('n', '<leader>q', '<cmd>q<cr>')
map('n', '<leader>w', '<cmd>w<cr>')
map('n', '<leader>x', '<cmd>x<cr>')
map('n', 'Y', 'yVaB') -- yank whole block

-- Navigate in insert mode --
map('i', '<C-h>', '<Left>')
map('i', '<C-k>', '<Up>')
map('i', '<C-j>', '<Down>')
map('i', '<C-l>', '<Right>')

-- Kybinds for splitting
map('n', '<leader>sv', '<C-w>v')
map('n', '<leader>ss', '<C-w>s')

-- Keybinds to make split navigation easier.
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Diagnostic keymaps
map('n', '<C-p>', function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Go to previous [D]iagnostic message' })
map('n', '<C-n>', function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>oq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

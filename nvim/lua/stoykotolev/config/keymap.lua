local map = vim.keymap.set
local opts = { silent = true }

-- setting leader to space
vim.g.mapleader = " "
map("n", "<leader>j", "ddp", opts)
map("n", "<leader>k", "ddkP", opts)
map("n", "<C-a>", "gg<S-v>G", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)
map("n", "yw", "yiw", opts)
map("n", "x", '"_x', opts)
map("n", "<C-s>", "<cmd> w <CR>", opts) -- save file

-- move cursor in different windows
map("", "<C-h>", "<C-w>h")
map("", "<C-k>", "<C-w>k")
map("", "<C-j>", "<C-w>j")
map("", "<C-l>", "<C-w>l")

-- Navigate in insert mode --
map("i", "<C-h>", "<Left>")
map("i", "<C-k>", "<Up>")
map("i", "<C-j>", "<Down>")
map("i", "<C-l>", "<Right>")

map("n", "<leader>x", "<cmd>bd<CR>", opts)

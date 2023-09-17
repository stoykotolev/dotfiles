local map = vim.keymap.set
local opts = { silent = true }

-- setting leader to space
vim.g.mapleader = " "

-- remaps
map("n", "<leader>j", "ddp", opts)
map("n", "<leader>k", "ddkP", opts)
map("n", "<C-a>", "%y+", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)
map("n", "yw", "yiw", opts)
map("n", "x", '"_x', opts)
map("n", "<C-s>", "<cmd> w <CR>", opts)

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

-- Nvimtree
map("n", "<C-e>", "<cmd> NvimTreeToggle<CR>", opts)

-- Tabs --
map("n", "<leader>t", "<cmd> tabedit<CR>", opts)
map("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", opts)
map("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", opts)
map("n", "<leader>x", "<cmd>bd<CR>", opts)

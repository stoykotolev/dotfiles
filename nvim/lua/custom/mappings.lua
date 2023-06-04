local M = {}

M.disabled = {
  n = {
    ["<leader>h"] = "",
    ["<leader>v"] = "",
  },
}

M.base = {
  n = {
    ["<leader>j"] = { "ddp" },
    ["<leader>k"] = { "ddkP" },
    ["<C-a>"] = { "gg<S-v>G" },
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },
    ["n"] = { "nzz" },
    ["N"] = { "Nzz" },
    ["yw"] = { "yiw" },
    ["x"] = { "_x" },
  },
}

M.lspconfig = {
  plugin = true,
  n = {
    ["<C-j>"] = vim.diagnostic.goto_next(),
  },
}

M.telescope = {
  plugin = true,
  n = {
    ["q"] = { "<cmd> Telescope close <CR>", "close" },
  },
  i = {
    ["<Down>"] = { "<cmd> Telescope cycle_history_next <CR>", "cycle history next" },
    ["<Up>"] = { "<cmd> Telescope cycle_history_prev <CR>", "cycle history prev" },
    ["<C-j>"] = { "<cmd> Telescope move_selection_next <CR>", "move selection next" },
    ["<C-k>"] = { "<cmd> Telescope move_selection_previous <CR>", "move selection previous" },
    ["<C-s>"] = { "<cmd> Telescope select_horizontal <CR>", "select horizontal" },
    ["<C-v>"] = { "<cmd> Telescope select_vertical <CR>", "select vertical" },
  },
}
return M

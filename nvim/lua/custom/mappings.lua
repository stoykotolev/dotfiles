local M = {}

M.disabled = {
  n = {
    ["<leader>h"] = "",
    ["<leader>v"] = "",
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debugging sidebar",
    },
  },
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require("dap-go").debug_test()
      end,
      "Debug go test",
    },
    ["<leader>dgl"] = {
      function()
        require("dap-go").debug_last()
      end,
      "Debug last go test",
    },
  },
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags",
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags",
    },
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

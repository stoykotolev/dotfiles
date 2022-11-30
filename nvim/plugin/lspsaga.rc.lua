local map = vim.keymap.set
local present, saga = pcall(require, 'lspsaga')
if not present then return end

saga.init_lsp_saga {
  border_style = "rounded",
  symbol_in_winbar = {
    enable = false
  }
}

local opts = { noremap = true, silent = true }

map('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
map('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
map('n', 'gh', '<Cmd>Lspsaga lsp_finder<CR>', opts)
map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
map('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
map("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
map('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
-- Only jump to error
map("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
map("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
-- Diagnsotic jump can use `<c-o>` to jump back
map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
-- Show line diagnostics
map("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostic
map("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

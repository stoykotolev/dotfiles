-- Keymaps
local map = vim.keymap.set
local opts = { silent = true }

local nmap_leader = function(suffix, rhs, desc)
  map('n', '<Leader>' .. suffix, rhs, { desc = desc })
end

-- Standard remaps --
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<C-a>', 'gg<S-v>G')
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)
map('n', 'n', 'nzz', opts)
map('n', 'N', 'Nzz', opts)
map('n', 'yw', 'yiw', opts)
map('n', 'x', '"_x', opts)
nmap_leader('q', '<cmd>q<cr>')
nmap_leader('w', '<cmd>w<cr>')
nmap_leader('x', '<cmd>x<cr>')
map('n', 'Y', 'yVaB') -- yank whole block

-- Navigation
map('i', '<C-h>', '<Left>')
map('i', '<C-k>', '<Up>')
map('i', '<C-j>', '<Down>')
map('i', '<C-l>', '<Right>')
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Splitting
nmap_leader('sv', '<C-w>v')
nmap_leader('ss', '<C-w>s')
nmap_leader('t', '<CMD>Oil<CR>', 'Open parent directory')

-- Picks
nmap_leader('ff', '<Cmd>Pick files<CR>', 'Files')
nmap_leader('<leader>', '<Cmd>Pick buffers<CR>', 'Files')
nmap_leader('fD', '<Cmd>Pick diagnostic scope="all"<CR>', 'Diagnostic workspace')
nmap_leader('fd', '<Cmd>Pick diagnostic scope="current"<CR>', 'Diagnostic buffer')
nmap_leader('fw', '<Cmd>Pick grep_live<CR>', 'Grep live')
nmap_leader('fcw', '<Cmd>Pick grep pattern="<cword>"<CR>', 'Grep current word')

-- LSP
local lsp_map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = 'LSP: ' .. desc })
end
lsp_map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
lsp_map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
lsp_map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
lsp_map('<leader>e', vim.diagnostic.open_float, 'Diagnostic popup')
lsp_map('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
lsp_map('<leader>ds', vim.lsp.buf.document_symbol, '[D]ocument [S]ymbols')
lsp_map('<leader>ws', vim.lsp.buf.workspace_symbol, '[W]orkspace [S]ymbols')
lsp_map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
lsp_map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
lsp_map('K', vim.lsp.buf.hover, 'Hover Documentation')
lsp_map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
lsp_map(
  '<C-n>',
  function() vim.diagnostic.jump({ count = 1, float = true }) end,
  'Go to next [D]iagnostic message'
)
lsp_map(
  '<C-p>',
  function() vim.diagnostic.jump({ count = -1, float = true }) end,
  'Go to previous [D]iagnostic message'
)

-- Noice
nmap_leader('na', '<Cmd>Noice<CR>', 'Noice all')

-- Completion
map('i', '<C-n>', '<C-x><C-o>', { desc = 'Trigger completion' })

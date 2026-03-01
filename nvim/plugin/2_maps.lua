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
_G.Maps.leader('q', '<cmd>q<cr>')
_G.Maps.leader('w', '<cmd>w<cr>')
_G.Maps.leader('x', '<cmd>x<cr>')
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
_G.Maps.leader('sv', '<C-w>v')
_G.Maps.leader('ss', '<C-w>s')
_G.Maps.leader('t', '<CMD>Oil<CR>', 'Open parent directory')

-- Lsp
_G.Maps.lsp('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
_G.Maps.lsp('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
_G.Maps.lsp('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
_G.Maps.lsp('<leader>e', vim.diagnostic.open_float, 'Diagnostic popup')
_G.Maps.lsp('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
_G.Maps.lsp('<leader>ds', vim.lsp.buf.document_symbol, '[D]ocument [S]ymbols')
_G.Maps.lsp('<leader>ws', vim.lsp.buf.workspace_symbol, '[W]orkspace [S]ymbols')
_G.Maps.lsp('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
_G.Maps.lsp('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
_G.Maps.lsp('K', vim.lsp.buf.hover, 'Hover Documentation')
_G.Maps.lsp('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
_G.Maps.lsp(
  '<C-n>',
  function() vim.diagnostic.jump({ count = 1, float = true }) end,
  'Go to next [D]iagnostic message'
)
_G.Maps.lsp(
  '<C-p>',
  function() vim.diagnostic.jump({ count = -1, float = true }) end,
  'Go to previous [D]iagnostic message'
)

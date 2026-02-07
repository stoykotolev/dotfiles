local now, add = MiniDeps.now, MiniDeps.add

now(function()
  add({
    source = 'pmizio/typescript-tools.nvim',
    depends = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
  })
  local api = require('typescript-tools.api')
  require('typescript-tools').setup({
    handlers = {
      ['textDocument/publishDiagnostics'] = api.filter_diagnostics({ 6133 }),
    },
    settings = {
      tsserver_file_preferences = {
        importModuleSpecifierPreference = 'non-relative',
      },
    },
  })
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.ts,*.tsx,*.jsx,*.js',
    callback = function() vim.cmd('TSToolsAddMissingImports sync') end,
  })
end)

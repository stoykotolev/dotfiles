return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    local mason = require 'mason'
    local mason_lspconfig = require 'mason-lspconfig'

    mason.setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
      ensure_installed = {
        'tailwindcss-language-server',
        'css-lsp',
        'html-lsp',
        'json-lsp',
        'marksman',
        'prettierd',
        'emmet-language-server',
        'eslint_d',
        'lua-language-server',
        'rust-analyzer',
        'gopls',
        'gofumpt',
        'golines',
        'goimports-reviser',
      },
    }

    mason_lspconfig.setup {
      ensure_installed = {
        -- webdev
        'tailwindcss',
        'cssls',
        'html',
        'graphql',
        --
        'lua_ls',
        'yamlls',
        'dockerls',
        'jsonls',
        'marksman', -- markdown
        'rust_analyzer',
        'gopls',
      },
      automatic_installation = true,
    }
  end,
}

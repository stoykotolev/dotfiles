return {
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      local rt = require 'rust-tools'
      local on_attach = function(_, bufnr)
        local lsp_buf = vim.lsp.buf
        local bufmap = function(keys, func)
          vim.keymap.set('n', keys, func, { buffer = bufnr })
        end

        bufmap('<leader>a', rt.code_action_group.code_action_group)
        bufmap('<leader>r', lsp_buf.rename)
        bufmap('<C-j>', vim.diagnostic.goto_next)
        bufmap('<C-k>', vim.diagnostic.goto_prev)
        bufmap('gd', lsp_buf.definition)
        bufmap('gD', lsp_buf.declaration)
        bufmap('gI', lsp_buf.implementation)
        bufmap('<leader>D', lsp_buf.type_definition)
        bufmap('K', rt.hover_actions.hover_actions)

        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          lsp_buf.format()
        end, {})
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local options = {
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
        },
      }
      rt.setup(options)
    end,
  },
}

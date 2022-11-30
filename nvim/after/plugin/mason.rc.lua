local present, mason = pcall(require, 'mason')
if not present then return end
local present2, lspconfig = pcall(require, 'mason-lspconfig')
if not present2 then return end

mason.setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",

    }
  }
})

lspconfig.setup {
  ensure_installed = {
    'tailwindcss',
    'sumneko_lua',
    'tsserver',
    'html',
    'cssls',
    'marksman',
    'elixirls',
    'jsonls',
  },
  automatic_installation = true
}

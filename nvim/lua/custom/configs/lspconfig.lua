local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local servers = { "html", "cssls", "tsserver", "lua_ls", "marksman", "jsonls", "tailwindcss", "prismals", "graphql" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }
end

-- TS
lspconfig.tsserver.setup {
  on_attach = on_attach,
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities,
}

-- Lua
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- recognize the vim global var.
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true), -- neovim runtime files
        checkThirdParty = false,
      },
    },
  },
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = util.root_pattern "Cargo.toml",
  settings = {
    ["rust_analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
}

local present, nvim_lsp = pcall(require, 'lspconfig')
if not present then return end

local protocol = require('vim.lsp.protocol')
local options = { noremap = true, silent = true }

-- local on_attach = function(client, bufnr)
-- 	if client.server_capabilities.documentFormattingProvider then
-- 		vim.api.nvim_command [[augroup Format]]
-- 		vim.api.nvim_command [[autocmd! * <buffer>]]
-- 		vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
-- 		vim.api.nvim_command [[augroup END]]
-- 	end
-- end

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", options)
	buf_set_keymap("n", "gh", "<Cmd>lua vim.lsp.buf.definition()<CR>", options)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", options)
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", options)
	buf_set_keymap("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", options)
	buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.rename()<CR>", options)
	buf_set_keymap("n", "<C-j>", "<Cmd>lua vim.diagnostic.goto_next()<CR>", options)
	buf_set_keymap("i", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", options)
end



protocol.CompletionItemKind = {
	"", -- Text
	"", -- Method
	"", -- Function
	"", -- Constructor
	"", -- Field
	"", -- Variable
	"", -- Class
	"ﰮ", -- Interface
	"", -- Module
	"", -- Property
	"", -- Unit
	"", -- Value
	"", -- Enum
	"", -- Keyword
	"﬌", -- Snippet
	"", -- Color
	"", -- File
	"", -- Reference
	"", -- Folder
	"", -- EnumMember
	"", -- Constant
	"", -- Struct
	"", -- Event
	"ﬦ", -- Operator
	"", -- TypeParameter
}

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- TS
nvim_lsp.tsserver.setup {
	on_attach = on_attach,
	cmd = { "typescript-language-server", "--stdio" },
	capabilities = capabilities
}

-- Lua
nvim_lsp.sumneko_lua.setup {
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' } -- recognize the vim global var.
			},

			workspace = {
				library = vim.api.nvim_get_runtime_file("", true), -- neovim runtime files
				checkThirdParty = false
			}
		}
	}
}

-- Markdown files
nvim_lsp.marksman.setup({})

-- JSON
nvim_lsp.jsonls.setup({
	capabilities = capabilities,
})

-- Tailwind
nvim_lsp.tailwindcss.setup({})

nvim_lsp.html.setup({
	capabilities = capabilities,
})

nvim_lsp.cssls.setup({
	capabilities = capabilities,
})

nvim_lsp.emmet_ls.setup({
	filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
	-- on_attach = function(client, bufnr)
	--   client.server_capabilities.hoverProvider = false
	--   on_attach(client, bufnr)
	-- end
})

-- PrismaORM
nvim_lsp.prismals.setup({})


-- Rust
nvim_lsp.rust_analyzer.setup({
	on_attach = on_attach
})

nvim_lsp.graphql.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.hoverProvider = false
		on_attach(client, bufnr)
	end
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	update_in_insert = true,
	float = {
		source = "always",
	},
})

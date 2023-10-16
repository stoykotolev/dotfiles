local on_attach = function(_, bufnr)
	local lsp_buf = vim.lsp.buf
	local bufmap = function(keys, func)
		vim.keymap.set("n", keys, func, { buffer = bufnr })
	end

	bufmap("<leader>a", lsp_buf.code_action)
	bufmap("<leader>r", lsp_buf.rename)
	bufmap("<C-j>", vim.diagnostic.goto_next)
	bufmap("<C-k>", vim.diagnostic.goto_prev)
	bufmap("gd", lsp_buf.definition)
	bufmap("gD", lsp_buf.declaration)
	bufmap("gI", lsp_buf.implementation)
	bufmap("<leader>D", lsp_buf.type_definition)
	bufmap("K", lsp_buf.hover)

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
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

require("rust-tools").setup(options)

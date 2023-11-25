return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			local formatting = null_ls.builtins.formatting
			local lint = null_ls.builtins.diagnostics
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			local sources = {
				formatting.prettierd,
				formatting.stylua,
				formatting.eslint_d,
				formatting.gofmt,
				formatting.goimports_reviser,
				formatting.golines,
				lint.eslint_d,
			}

			null_ls.setup({
				debug = true,
				sources = sources,
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			})
		end,
	},
}

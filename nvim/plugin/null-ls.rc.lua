local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		formatting.stylua,
		formatting.prettierd,
		formatting.prismafmt,
		formatting.rustfmt,
		formatting.gofmt,
		diagnostics.eslint_d.with({
			condition = function(utils)
				return utils.root_has_file({ ".eslintrc.*" })
			end,
		}),
		code_actions.eslint_d,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})

-- vim.api.nvim_create_user_command(
-- 	'DisableLspFormatting',
-- 	function()
-- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
-- 	end,
-- 	{ nargs = 0 }
-- )

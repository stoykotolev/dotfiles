local map = vim.keymap.set
local util = require("lspconfig/util")
local on_attach = function(_, bufnr)
	local lsp_buf = vim.lsp.buf
	local bufmap = function(keys, func)
		map("n", keys, func, { buffer = bufnr })
	end

	bufmap("<leader>a", lsp_buf.code_action)
	bufmap("<leader>r", lsp_buf.rename)
	bufmap("<C-j>", vim.diagnostic.goto_next)
	bufmap("<C-k>", vim.diagnostic.goto_prev)
	bufmap("gd", "<cmd>Telescope lsp_definitions<CR>")
	bufmap("gD", lsp_buf.declaration)
	bufmap("gI", lsp_buf.implementation)
	bufmap("<leader>D", lsp_buf.type_definition)
	bufmap("K", lsp_buf.hover)

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		lsp_buf.format()
	end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")

require("mason").setup({
	ensure_installed = { "lua-language-server", "eslint_d", "prettierd", "gofumpt", "goimports-reviser", "golines" },
	PATH = "skip",
	ui = {
		icons = {
			package_pending = " ",
			package_installed = "󰄳 ",
			package_uninstalled = " 󰚌",
		},
		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "X",
			cancel_installation = "<C-c>",
		},
	},
	max_concurrent_installers = 10,
})
require("mason-lspconfig").setup({
	ensure_installed = {
		-- webdev
		"tsserver",
		"tailwindcss",
		"cssls",
		"html",
		"graphql",
		--
		"lua_ls",
		"yamlls",
		"dockerls",
		"jsonls",
		"marksman", -- markdown
		"rust_analyzer",
		"gopls",
	},
})
require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,

	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = {
							"vim",
							"require",
						},
					},
				},
			},
		})
	end,
	["tsserver"] = function()
		lspconfig.tsserver.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = { "typescript-language-server", "--stdio" },
			init_options = {
				preferences = {
					disableSuggestions = true,
				},
			},
		})
	end,
	["graphql"] = function()
		lspconfig.graphql.setup({
			on_attach = on_attach,
			flags = {
				debounce_text_changes = 150,
			},
			capabilities = capabilities,
		})
	end,
	["gopls"] = function()
		lspconfig.gopls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = util.root_pattern("go.work", "go.mod"),
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					analyses = {
						unusedparams = true,
					},
				},
			},
		})
	end,
})

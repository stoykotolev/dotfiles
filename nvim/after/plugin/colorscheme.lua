-- require("nvim-tundra").setup({
-- 	transparent_background = true,
-- 	dim_inactive_windows = {
-- 		enabled = false,
-- 		color = nil,
-- 	},
-- 	sidebars = {
-- 		enabled = true,
-- 		color = nil,
-- 	},
-- 	editor = {
-- 		search = {},
-- 		substitute = {},
-- 	},
-- 	syntax = {
-- 		booleans = { bold = true, italic = true },
-- 		comments = { bold = true, italic = true },
-- 		conditionals = {},
-- 		constants = { bold = true },
-- 		fields = {},
-- 		functions = {},
-- 		keywords = {},
-- 		loops = {},
-- 		numbers = { bold = true },
-- 		operators = { bold = true },
-- 		punctuation = {},
-- 		strings = {},
-- 		types = { italic = true },
-- 	},
-- 	diagnostics = {
-- 		errors = {},
-- 		warnings = {},
-- 		information = {},
-- 		hints = {},
-- 	},
-- 	plugins = {
-- 		lsp = true,
-- 		semantic_tokens = true,
-- 		treesitter = true,
-- 		telescope = true,
-- 		nvimtree = true,
-- 		cmp = true,
-- 		context = true,
-- 		dbui = true,
-- 		gitsigns = true,
-- 		neogit = true,
-- 		textfsm = true,
-- 	},
-- 	overwrite = {
-- 		colors = {},
-- 		highlights = {},
-- 	},
-- })
-- vim.cmd("colorscheme tundra")

require("onedark").setup({
	style = "darker",
	transparent = true, -- Show/hide background
	term_colors = false, -- Change terminal color as per the selected theme style
})
require("onedark").load()

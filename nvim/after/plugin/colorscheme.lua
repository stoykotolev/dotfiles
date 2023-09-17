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
	colors = {
		black = "#24292f",
		bg0 = "#1f2329",
		bg1 = "#282c34",
		bg2 = "#30363f",
		bg3 = "#323641",
		bg_d = "#181b20",
		bg_blue = "#4f6286",
		bg_yellow = "#e3786c",
		fg = "#a0a8b7",
		purple = "#a97594",
		green = "#618774",
		orange = "#cc9057",
		blue = "#5c6b92",
		yellow = "#e2b86b",
		cyan = "#6ba5ab",
		red = "#dc6f7a",
		grey = "#535965",
		light_grey = "#7a818e",
		dark_cyan = "#4f8896",
		dark_red = "#8b3434",
		dark_yellow = "#835d1a",
		dark_purple = "#b589a4",
		diff_add = "#272e23",
		diff_delete = "#2d2223",
		diff_change = "#172a3a",
		diff_text = "#274964",
		diagnostics = {
			darker = true, -- darker colors for diagnostic
			undercurl = true, -- use undercurl instead of underline for diagnostics
			background = true, -- use background color for virtual text
		},
	},
})
require("onedark").load()

-- tokyonight configuration --
-- local present, t = pcall(require, 'tokyonight')
-- if not present then return end
--
-- t.setup({
--   style = "night",
--   transparent = true,
--   terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
--   styles = {
--     keywords = { italic = true },
--     -- Background styles. Can be "dark", "transparent" or "normal"
--     sidebars = "transparent", -- style for sidebars, see below
--     floats = "transparent", -- style for floating windows
--   },
-- })
-- ---------------------------

-- Mellow theme configuration --
-- vim.g.mellow_transparent = true
-- vim.g.mellow_italic_functions = true
-- vim.g.mellow_italic_comments = true
-- vim.g.mellow_bold_functions = true
-- vim.cmd [[colorscheme mellow]]

--------------------------------

-- Rose pine configuration --
-- function Colors(color)
-- 	color = color or 'rose-pine'
-- 	vim.cmd.colorscheme(color)
--
-- 	vim.api.nvim_set_hl(0, 'NormalFloat', { bg = "none" })
-- 	vim.api.nvim_set_hl(0, 'Normal', { bg = "none" })
-- end
--
-- Colors()
----------------------------

-- Catppuccin configuration --
-- local present, catppuccin = pcall(require, "catppuccin")
-- if not present then
-- 	return
-- end
--
-- catppuccin.setup({
-- 	flavour = "mocha", -- latte, frappe, macchiato, mocha
-- 	background = { -- :h background
-- 		light = "latte",
-- 		dark = "mocha",
-- 	},
-- 	transparent_background = true,
-- 	show_end_of_buffer = false, -- show the '~' characters after the end of buffers
-- 	term_colors = false,
-- 	no_italic = false, -- Force no italic
-- 	no_bold = false, -- Force no bold
-- 	styles = {
-- 		comments = { "italic" },
-- 		conditionals = { "italic" },
-- 	},
-- 	color_overrides = {
-- 		all = {
-- 			surface0 = "#feffed",
-- 			surface1 = "#feffed",
-- 			surface2 = "#feffed",
-- 			subtext1 = ""
-- 		},
-- 	},
-- 	custom_highlights = {},
-- 	integrations = {
-- 		cmp = true,
-- 		gitsigns = true,
-- 		nvimtree = true,
-- 		telescope = true,
-- 		notify = false,
-- 		mini = false,
-- 		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
-- 	},
-- })

-- Kanagawa configuration --

require("kanagawa").setup({
	compile = false, -- enable compiling the colorscheme
	undercurl = true, -- enable undercurls
	commentStyle = { italic = true },
	functionStyle = {},
	keywordStyle = { italic = false },
	statementStyle = { bold = true },
	transparent = true, -- do not set background color
	dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	terminalColors = true, -- define vim.g.terminal_color_{0,17}
	colors = { -- add/modify theme and palette colors
		palette = {
			samuraiRed = "#dc6f7a",
			waveRed = "#dc6f7a",
			peachRed = "#dc6f7a",
			winterRed = "#dc6f7a",
			autumnRed = "#dc6f7a",
			dragonRed = "#dc6f7a",
			lotusRed = "#dc6f7a",
			lotusRed2 = "#dc6f7a",
			lotusRed3 = "#dc6f7a",
			lotusRed4 = "#dc6f7a",
		},
		theme = { wave = {}, lotus = {}, dragon = {}, all = {
			ui = {
				bg_gutter = "none",
			},
		} },
	},
	theme = "wave", -- Load "wave" theme when 'background' option is not set
	background = { -- map the value of 'background' option to a theme
		dark = "wave", -- try "dragon" !
		light = "lotus",
	},
})
vim.cmd.colorscheme("kanagawa")

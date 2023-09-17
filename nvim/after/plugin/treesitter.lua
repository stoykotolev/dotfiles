require("nvim-treesitter.configs").setup({
	ensure_installed = {
		-- defaults
		"vim",
		"lua",
		"markdown",

		-- web dev
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"graphql",

		-- General programing
		"rust",
		"go",
		"json",
		"yaml",

		-- devops stuff
		"dockerfile",
	},
	auto_install = true,
	highlight = {
		enable = true,
		use_language = true,
		disable = {},
	},
	matchup = {
		enable = true,
	},
	indent = {
		enable = true,
		disable = {},
	},
	autotag = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})

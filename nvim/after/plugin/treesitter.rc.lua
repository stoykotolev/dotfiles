local present, tsitter = pcall(require, "nvim-treesitter.configs")
if not present then
	return
end

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
local install_config = require("nvim-treesitter.install")

tsitter.setup({
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
	ensure_installed = {
		"css",
		"html",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"prisma",
		"rust",
		"tsx",
		"typescript",
		"yaml",
	},
})

return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function(_, opts)
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
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
				autotag = {
					enable = true,
				},
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup()
		end,
	},
}

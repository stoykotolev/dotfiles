return {
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			opleader = {
				line = "<leader>/",
			},
		},
		lazy = false,
	},
	{
		"navarasu/onedark.nvim",
		lazy = false,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"typescript-language-server",
				"tailwindcss-language-server",
				"css-lsp",
				"html-lsp",
				"json-lsp",
				"marksman",
				"prettierd",
				"eslint_d",
				"stylua",
				"rust-analyzer",
				"gopls",
				"golines",
				"goimports-reviser",
			},
		},
	},
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-nvim-lsp",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	{
		"windwp/nvim-autopairs",
		-- Optional dependency
		config = function()
			require("nvim-autopairs").setup({})
			-- If you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "󰍵" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "│" },
				},
			})
		end,
	},
	{
		"dinhhuy258/git.nvim",
		config = function()
			require("git").setup({
				keymaps = {
					-- Open blame window
					blame = "<Leader>gb",
					-- Open file/folder in git repository
					browse = "<Leader>go",
				},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "tabs",
					separator_style = "slant",
					always_show_bufferline = true,
					show_buffer_close_icons = false,
					show_close_icon = false,
					color_icons = true,
				},
				highlights = {
					separator = {
						fg = "#073642",
						bg = "#002b36",
					},
					separator_selected = {
						fg = "#073642",
					},
					background = {
						fg = "#657b83",
						bg = "#002b36",
					},
					buffer_selected = {
						fg = "#fdf6e3",
						bold = true,
					},
					fill = {
						bg = "#073642",
					},
				},
			})
		end,
	},
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	event = "VeryLazy",
	-- },
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		config = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	{
		"mfussenegger/nvim-dap",
	},
}

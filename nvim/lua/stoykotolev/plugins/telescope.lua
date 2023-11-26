return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-n>"] = actions.select_tab,
						["<C-d>"] = require("telescope.actions").delete_buffer,
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
					n = {
						["q"] = actions.close,
						["dd"] = require("telescope.actions").delete_buffer,
						["x"] = require("telescope.actions").delete_buffer,
					},
				},
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				border = {},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,
				use_less = true,
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
				file_browser = {
					hijack_netrw = true,
				},
			},
		})
	end,
	keys = {
		{
			"<leader>ff",
			"<cmd>Telescope find_files<cr>",
			{ desc = "Fuzzy find files in cwd" },
		},
		{
			"<leader>fw",
			"<cmd>Telescope live_grep<cr>",
			{ desc = "Find string in cwd" },
		},
		{
			"<leader>fr",
			"<cmd>Telescope oldfiles<cr>",
			{ desc = "Fuzzy find recent files" },
		},
		{
			"<leader>b",
			"<cmd>Telescope buffers<cr>",
			{ desc = "Show current open buffers" },
		},
	},
}

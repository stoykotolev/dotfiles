return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { -- If encountering errors, see telescope-fzf-native README for installation instructions
                "nvim-telescope/telescope-fzf-native.nvim",

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = "make",

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            { "nvim-telescope/telescope-ui-select.nvim" },

            { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-n>"] = require("telescope.actions").select_tab,
                            ["<C-d>"] = require("telescope.actions").delete_buffer,
                            ["<C-k>"] = require("telescope.actions").move_selection_previous, -- move to prev result
                            ["<C-j>"] = require("telescope.actions").move_selection_next,     -- move to next result
                            ["<C-q>"] = require("telescope.actions").send_selected_to_qflist
                                + require("telescope.actions").open_qflist,
                        },
                        n = {
                            ["q"] = require("telescope.actions").close,
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
                    borderchars = {
                        "─",
                        "│",
                        "─",
                        "│",
                        "╭",
                        "╮",
                        "╯",
                        "╰",
                    },
                    color_devicons = true,
                    use_less = true,
                    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                    file_browser = {
                        hijack_netrw = true,
                    },
                },
            })

            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")

            local builtin = require("telescope.builtin")
            vim.keymap.set(
                "n",
                "<leader>sh",
                builtin.help_tags,
                { desc = "[S]earch [H]elp" }
            )
            vim.keymap.set(
                "n",
                "<leader>sk",
                builtin.keymaps,
                { desc = "[S]earch [K]eymaps" }
            )
            vim.keymap.set(
                "n",
                "<leader>ff",
                builtin.find_files,
                { desc = "[F]ind [F]iles" }
            )
            vim.keymap.set(
                "n",
                "<leader>st",
                builtin.builtin,
                { desc = "[S]earch Select [T]elescope" }
            )
            vim.keymap.set(
                "n",
                "<leader>fcw",
                builtin.grep_string,
                { desc = "[F]ind [C]urrent [W]ord" }
            )
            vim.keymap.set(
                "n",
                "<leader>fw",
                builtin.live_grep,
                { desc = "[F]ind by [W]ord" }
            )
            vim.keymap.set(
                "n",
                "<leader>sd",
                builtin.diagnostics,
                { desc = "[S]earch [D]iagnostics" }
            )
            vim.keymap.set(
                "n",
                "<leader>sr",
                builtin.resume,
                { desc = "[S]earch [R]esume" }
            )
            vim.keymap.set(
                "n",
                "<leader>s.",
                builtin.oldfiles,
                { desc = '[S]earch Recent Files ("." for repeat)' }
            )
            vim.keymap.set(
                "n",
                "<leader><leader>",
                builtin.buffers,
                { desc = "[ ] Find existing buffers" }
            )

            vim.keymap.set("n", "<leader>/", function()
                builtin.current_buffer_fuzzy_find(
                    require("telescope.themes").get_dropdown({
                        winblend = 10,
                        previewer = false,
                    })
                )
            end, { desc = "[/] Fuzzily search in current buffer" })

            vim.keymap.set("n", "<leader>s/", function()
                builtin.live_grep({
                    grep_open_files = true,
                    prompt_title = "Live Grep in Open Files",
                })
            end, { desc = "[S]earch [/] in Open Files" })

            vim.keymap.set("n", "<leader>sn", function()
                builtin.find_files({ cwd = vim.fn.stdpath("config") })
            end, { desc = "[S]earch [N]eovim files" })
        end,
    },
}

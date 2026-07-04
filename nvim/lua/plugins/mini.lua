return {
    {
        "nvim-mini/mini.nvim",
        config = function()
            require("mini.ai").setup({ n_lines = 500 })
            local surround = require("mini.surround")
            surround.setup({
                mappings = {
                    add = "<leader>as", -- Add surrounding in Normal and Visual modes
                    delete = "", -- Delete surrounding unbound (<leader>ds retired, VISION.md D8)
                    find = "<leader>fs", -- Find surrounding (to the right)
                    find_left = "sF", -- Find surrounding (to the left)
                    highlight = "<leader>hs", -- Highlight surrounding
                    replace = "<leader>rs", -- Replace surrounding
                    suffix_last = "l", -- Suffix to search with "prev" method
                    suffix_next = "n", -- Suffix to search with "next" method
                },
            })
            -- mini.nvim removed the `update_n_lines` mapping option; bind it
            -- manually to keep the old `sn` muscle memory (VISION.md §4.5).
            vim.keymap.set("n", "sn", surround.update_n_lines, { desc = "Update MiniSurround `n_lines`" })
            local statusline = require("mini.statusline")
            statusline.setup({ use_icons = vim.g.have_nerd_font })

            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                return "%2l:%-2v"
            end
        end,
    },
}

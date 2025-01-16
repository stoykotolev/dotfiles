return {
    {
        "echasnovski/mini.nvim",
        config = function()
            require("mini.ai").setup({ n_lines = 500 })
            require("mini.surround").setup({
                mappings = {
                    add = "<leader>as", -- Add surrounding in Normal and Visual modes
                    delete = "<leader>ds", -- Delete surrounding
                    find = "<leader>fs", -- Find surrounding (to the right)
                    find_left = "sF", -- Find surrounding (to the left)
                    highlight = "<leader>hs", -- Highlight surrounding
                    replace = "<leader>rs", -- Replace surrounding
                    update_n_lines = "sn", -- Update `n_lines`
                    suffix_last = "l", -- Suffix to search with "prev" method
                    suffix_next = "n", -- Suffix to search with "next" method
                },
            })
            local statusline = require("mini.statusline")
            statusline.setup({ use_icons = vim.g.have_nerd_font })

            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                return "%2l:%-2v"
            end
        end,
    },
}

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

require("mini.pairs").setup()

-- Auto-close/rename JSX and HTML tags
require("nvim-ts-autotag").setup({})

-- Convert quotes to backticks when typing ${} in JS/TS strings
require("template-string").setup({
    filetypes = { "html", "typescript", "javascript", "typescriptreact", "javascriptreact" },
    jsx_brackets = true,
})

-- Context-aware commentstring so native gc comments JSX correctly
vim.g.skip_ts_context_commentstring_module = true
require("ts_context_commentstring").setup({ enable_autocmd = false })
local get_option = vim.filetype.get_option
---@diagnostic disable-next-line: duplicate-set-field
vim.filetype.get_option = function(filetype, option)
    return option == "commentstring"
            and require("ts_context_commentstring.internal").calculate_commentstring()
        or get_option(filetype, option)
end

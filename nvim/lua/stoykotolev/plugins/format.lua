local autocmd = vim.api.nvim_create_autocmd
return {
    {
        "stevearc/conform.nvim",
        lazy = false,
        opts = {
            notify_on_error = false,
            format_on_save = {
                timeout_ms = 100,
                lsp_fallback = true,
            },
            formatters_by_ft = {
                lua = { "stylua" },
            },
        },
    },
    -- Linting
    {
        "mfussenegger/nvim-lint",
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                markdown = { "markdownlint" },
            }
            autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
    "tpope/vim-sleuth",
    { "numToStr/Comment.nvim", opts = {} },
}

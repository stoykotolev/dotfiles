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
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" }
            },
        },
    },
    -- Linting
    {
        'mfussenegger/nvim-lint',
        config = function()
            require('lint').linters_by_ft = {
                markdown = { "markdownlint" },
                javascript = { 'eslint_d' },
                typescript = { 'eslint_d' },
                javascriptreact = { 'eslint_d' },
                typescriptreact = { 'eslint_d' },
            }
            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                callback = function()
                    require('lint').try_lint()
                end,
            })
        end,
    },
    "tpope/vim-sleuth",
    {
        'numToStr/Comment.nvim',
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        config = function()
            require('ts_context_commentstring').setup {
                enable_autocmd = false,
            }
            require('Comment').setup {
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            }
        end,
    }
}

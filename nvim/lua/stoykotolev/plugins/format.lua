local autocmd = vim.api.nvim_create_autocmd
local linter_root_markers = {
    biomejs = { "biome.json", "biome.jsonc" },
    eslint_d = {
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
        "eslint.config.ts",
        "eslint.config.mts",
        "eslint.config.cts",
        -- deprecated
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        ".eslintrc.json",
    },
}
return {
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    javascript = { "prettierd", },
                    javascriptreact = { "prettierd" },
                    typescript = { "prettierd" },
                    typescriptreact = { "prettierd" },
                    yaml = { "yamlfmt" },
                    html = { "prettierd" },
                    css = { "prettierd" },
                    json = { "prettierd" },
                    markdown = { "prettierd" },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_format = "fallback",
                },
            })
        end,
    },
    -- Linting
    {
        'mfussenegger/nvim-lint',
        opts = {
            linters_by_ft = {
                markdown = { "markdownlint" },
                javascript = { 'eslint_d', 'biomejs' },
                typescript = { 'eslint_d', 'biomejs' },
                javascriptreact = { 'eslint_d', 'biomejs' },
                typescriptreact = { 'eslint_d', 'biomejs' },
                go = { "golangcilint" }
            }
        },
        config = function(_, opts)
            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                group = lint_augroup,
                callback = function()
                    local lint = require('lint')
                    if vim.opt_local.modifiable:get() then
                        local names = opts.linters_by_ft[vim.bo.filetype]

                        if names == nil then
                            return
                        end

                        for _, name in pairs(names) do
                            local next = next
                            if
                                linter_root_markers[name] == nil or next(vim.fs.find(linter_root_markers[name], { upward = true }))
                            then
                                lint.try_lint(name)
                            end
                        end
                    end
                end,
            })
        end,
    },
    {
        "stoykotolev/eslint-code-actions.nvim",
        keys = {
            {
                "<leader>da", "<cmd>GetDiagnosics<CR>", "Show Eslint [D]iagnostics [A]ctions"
            }
        },
        opts = {}
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

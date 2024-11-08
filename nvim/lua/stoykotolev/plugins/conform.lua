return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                javascript = { "prettierdd", stop_after_first = true },
                javascriptreact = { "prettierd", stop_after_first = true },
                typescript = { "prettierd", stop_after_first = true },
                typescriptreact = { "prettierd", stop_after_first = true },
                yaml = { "yamlfmt" },
                html = { "prettierd" },
                json = { "prettierd" },
                markdown = { "prettierd" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                require("conform").format({ bufnr = args.buf })
            end,
        })
    end,
}

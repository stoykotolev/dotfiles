-- HARD INVARIANT: conform owns format-on-save exclusively. Nothing else may
-- format on BufWritePre — exactly one format pass per save.
require("conform").setup({
    formatters_by_ft = {
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        graphql = { "prettierd" },
        markdown = { "prettierd" },
        go = { "goimports", "gofumpt" },
        lua = { "stylua" },
    },
    format_on_save = {
        timeout_ms = 500,
        -- Only formats via LSP when no formatter is configured for the
        -- filetype; never runs both.
        lsp_format = "fallback",
    },
})

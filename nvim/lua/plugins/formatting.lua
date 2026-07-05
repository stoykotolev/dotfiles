-- HARD INVARIANT: this file exclusively owns what happens to the buffer on
-- save. One eslint fix-all pass (only where the eslint LSP is attached),
-- then exactly ONE format pass via conform. Nothing else may hook
-- BufWritePre.
local conform = require("conform")

conform.setup({
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
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("format-on-save", { clear = true }),
    callback = function(args)
        -- Apply eslint auto-fixes first (synchronous), so prettier formats
        -- the fixed code. LspEslintFixAll is created by nvim-lspconfig's
        -- eslint on_attach.
        if #vim.lsp.get_clients({ bufnr = args.buf, name = "eslint" }) > 0 then
            vim.api.nvim_buf_call(args.buf, function()
                vim.cmd("LspEslintFixAll")
            end)
        end
        conform.format({
            bufnr = args.buf,
            timeout_ms = 500,
            -- Only formats via LSP when no formatter is configured for the
            -- filetype; never runs both.
            lsp_format = "fallback",
        })
    end,
})

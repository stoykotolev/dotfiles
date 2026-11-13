-- HARD INVARIANT: this file exclusively owns what happens to the buffer on
-- save. Unused imports are dropped, then one eslint fix-all pass (only
-- where the eslint LSP is attached), then exactly ONE format pass via
-- conform. Nothing else may hook BufWritePre.
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
        rust = { "rustfmt" },
        lua = { "stylua" },
    },
})

-- Unused imports: goimports already strips them for Go; for the rest, ask
-- the attached server for its "remove unused imports" code action and apply
-- it synchronously. `only` filters the request by kind; `title` picks the
-- action where the kind alone is not specific enough.
local unused_import_actions = {
    vtsls = { only = { "source.removeUnusedImports" } },
    ["rust-analyzer"] = { only = { "quickfix" }, title = "Remove all unused imports" },
}

local function remove_unused_imports(bufnr)
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        local spec = unused_import_actions[client.name]
        if spec then
            local params = {
                textDocument = vim.lsp.util.make_text_document_params(bufnr),
                range = {
                    start = { line = 0, character = 0 },
                    ["end"] = { line = vim.api.nvim_buf_line_count(bufnr), character = 0 },
                },
                context = { diagnostics = {}, only = spec.only },
            }
            local res = client:request_sync("textDocument/codeAction", params, 1000, bufnr)
            for _, action in ipairs(res and res.result or {}) do
                if not spec.title or action.title == spec.title then
                    -- Servers may leave the edit out until asked to resolve it
                    if not action.edit and client:supports_method("codeAction/resolve") then
                        local resolved = client:request_sync("codeAction/resolve", action, 1000, bufnr)
                        action = resolved and resolved.result or action
                    end
                    if action.edit then
                        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
                    end
                    break
                end
            end
        end
    end
end

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("format-on-save", { clear = true }),
    callback = function(args)
        remove_unused_imports(args.buf)
        -- Apply eslint auto-fixes next (synchronous), so prettier formats
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

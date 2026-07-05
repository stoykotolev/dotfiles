-- nvim-lint is used narrowly: only for languages whose linter has no good
-- LSP story. ESLint runs as an LSP server (see plugins/lsp.lua).
local lint = require("lint")

lint.linters_by_ft = {
    go = { "golangcilint" },
    markdown = { "markdownlint" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("lint", { clear = true }),
    callback = function()
        if vim.opt_local.modifiable:get() then
            lint.try_lint(nil, { ignore_errors = true })
        end
    end,
})

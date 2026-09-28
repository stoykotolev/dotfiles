local M = {}

-- Ordered: later modules override earlier ones (plugins last).
-- nvim-web-devicons is deliberately not overridden — brand colours carry
-- filetype recognition.
M.modules = {
    "yugure.groups.editor",
    "yugure.groups.syntax",
    "yugure.groups.treesitter",
    "yugure.groups.markup",
    "yugure.groups.lsp",
    "yugure.groups.plugins.telescope",
    "yugure.groups.plugins.blink",
    "yugure.groups.plugins.oil",
    "yugure.groups.plugins.mini",
    "yugure.groups.plugins.gitsigns",
    "yugure.groups.plugins.todo_comments",
    "yugure.groups.plugins.render_markdown",
    "yugure.groups.plugins.fidget",
    "yugure.groups.plugins.neotest",
    "yugure.groups.plugins.dap",
    "yugure.groups.plugins.ts_context",
}

function M.load()
    local p = require("yugure.palette")

    local merged = {}
    for _, mod in ipairs(M.modules) do
        for name, spec in pairs(require(mod)(p)) do
            merged[name] = spec
        end
    end
    M.groups = merged

    -- Forward links are fine: `link` resolves by name at draw time.
    for name, spec in pairs(merged) do
        vim.api.nvim_set_hl(0, name, spec)
    end

    require("yugure.terminal").apply(p)
end

return M

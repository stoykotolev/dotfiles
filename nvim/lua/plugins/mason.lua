require("mason").setup()

-- Everything external lives in Mason: LSP servers, formatters, linters,
-- debug adapters. Installed automatically when missing.
local tools = {
    -- LSP servers
    "vtsls",
    "eslint-lsp",
    "tailwindcss-language-server",
    "gopls",
    "yaml-language-server",
    "dockerfile-language-server",
    "lua-language-server",
    -- Formatters
    "prettierd",
    "gofumpt",
    "goimports",
    "stylua",
    -- Linters
    "golangci-lint",
    "markdownlint",
    -- Debug adapters
    "js-debug-adapter",
    "delve",
}

local function ensure_installed()
    local registry = require("mason-registry")
    for _, name in ipairs(tools) do
        local ok, pkg = pcall(registry.get_package, name)
        if ok and not pkg:is_installed() then
            vim.notify("[mason] installing " .. name, vim.log.levels.INFO)
            pkg:install()
        end
    end
end

require("mason-registry").refresh(vim.schedule_wrap(ensure_installed))

return { tools = tools }

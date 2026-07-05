local langs = {
    "bash",
    "css",
    "diff",
    "dockerfile",
    "go",
    "gomod",
    "gosum",
    "gowork",
    "graphql",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "query",
    "regex",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
}

-- jsonc has no grammar of its own; it is parsed by the json one
vim.treesitter.language.register("json", "jsonc")

-- Async; skips grammars that are already installed
require("nvim-treesitter").install(langs)

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
    callback = function(ev)
        if not pcall(vim.treesitter.start, ev.buf) then
            return
        end
        -- <CR> in the cmdwin must keep executing the command line
        if vim.fn.getcmdwintype() ~= "" then
            return
        end
        local sel = require("core.selection")
        vim.keymap.set("n", "<CR>", sel.init, { buffer = ev.buf, desc = "Start incremental selection" })
        vim.keymap.set("x", "<CR>", sel.increment, { buffer = ev.buf, desc = "Grow selection to parent node" })
        vim.keymap.set("x", "<BS>", sel.decrement, { buffer = ev.buf, desc = "Shrink selection" })
    end,
})

require("treesitter-context").setup({
    max_lines = 1,
})

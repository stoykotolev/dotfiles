-- Short end-of-line hints everywhere except the cursor line; the cursor
-- line instead gets the full multi-line rendering of its diagnostics.
vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = false,
    float = { border = "rounded", source = "if_many" },
    virtual_text = { current_line = false },
    virtual_lines = { current_line = true },
})

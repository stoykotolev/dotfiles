-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "json", "jsonc", "markdown" },
    callback = function()
        vim.opt.conceallevel = 0
    end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup(
        "kickstart-highlight-yank",
        { clear = true }
    ),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- close quickfix menu after selecting choice
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf" },
    command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

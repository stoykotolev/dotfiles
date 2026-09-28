local autocmd = vim.api.nvim_create_autocmd

-- Disable concealing in file formats where hidden characters are confusing
autocmd("FileType", {
    pattern = { "json", "jsonc", "markdown" },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})

-- Highlight when yanking (copying) text
autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- close quickfix menu after selecting choice
autocmd("FileType", {
    pattern = { "qf" },
    callback = function(event)
        local map = function(lhs, rhs)
            vim.keymap.set("n", lhs, rhs, { buffer = event.buf })
        end

        -- Open the entry under the cursor in a split (telescope-style)
        local open_in = function(split_cmd)
            return function()
                local idx = vim.fn.line(".")
                local is_loclist = vim.fn.getwininfo(vim.fn.win_getid())[1].loclist == 1
                if is_loclist then
                    vim.cmd("lclose")
                    vim.cmd(split_cmd)
                    vim.cmd(idx .. "ll")
                else
                    vim.cmd("cclose")
                    vim.cmd(split_cmd)
                    vim.cmd(idx .. "cc")
                end
            end
        end

        map("<CR>", "<CR>:cclose<CR>")
        map("<C-v>", open_in("vsplit"))
        map("<C-x>", open_in("split"))
    end,
})

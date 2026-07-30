-- gopher.nvim: Go chores — struct tags (gomodifytags), iferr, impl,
-- gotests. Binaries are installed by Mason (see plugins/mason.lua).
require("gopher").setup({})

-- Keymaps only make sense in Go buffers.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    group = vim.api.nvim_create_augroup("gopher-keymaps", { clear = true }),
    callback = function(ev)
        local function bmap(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
        end

        bmap("<leader>gaj", "<cmd>GoTagAdd json<cr>", "[G]o [A]dd [J]son tags")
        bmap("<leader>gay", "<cmd>GoTagAdd yaml<cr>", "[G]o [A]dd [Y]aml tags")
        bmap("<leader>grj", "<cmd>GoTagRm json<cr>", "[G]o [R]emove [J]son tags")
        bmap("<leader>gry", "<cmd>GoTagRm yaml<cr>", "[G]o [R]emove [Y]aml tags")
        bmap("<leader>gc", "<cmd>GoCmt<cr>", "[G]o doc [C]omment")
        bmap("<leader>gt", "<cmd>GoTestAdd<cr>", "[G]o generate [T]est for function")
        -- GoImpl needs args (receiver + interface), leave the cmdline open
        vim.keymap.set("n", "<leader>gi", ":GoImpl ", { buffer = ev.buf, desc = "[G]o [I]mpl interface" })
    end,
})

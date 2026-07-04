-- Picker engine: mini.pick + mini.extra (VISION.md D1).
-- This file owns the picker setup AND all picker keymaps so a future engine
-- swap (undo plan: snacks.picker) is a rewrite of this one file only.
--
-- mini.pick / mini.extra ship inside the mini.nvim plugin declared in
-- mini.lua. lazy.nvim resolves duplicate `config` fragments last-one-wins,
-- so this is a virtual spec (no install, loads after mini.nvim) that keeps
-- picker configuration separate from mini.lua's module setups.
return {
    {
        "picker",
        virtual = true,
        dependencies = { "nvim-mini/mini.nvim" },
        config = function()
            local pick = require("mini.pick")
            local extra = require("mini.extra")

            pick.setup({
                mappings = {
                    move_down = "<C-j>",
                    move_up = "<C-k>",
                    -- Default choose_marked behavior (MiniPick.default_choose_marked)
                    -- sends marked file/buffer items to the quickfix list.
                    choose_marked = "<C-q>",
                    -- Paste stays on the default <C-r> (register-prompt paste, D1).
                },
            })
            -- Registers the extra pickers (diagnostic, keymaps, oldfiles, ...)
            -- in MiniPick.registry.
            extra.setup()

            -- Route vim.ui.select through mini.pick. MiniPick.setup() already
            -- does this; kept explicit because D1 depends on it.
            vim.ui.select = pick.ui_select

            -- Custom picker over MiniPick.registry that invokes the chosen
            -- picker — the mini equivalent of telescope's `builtin.builtin`
            -- list. Recipe from :h MiniPick.registry.
            pick.registry.registry = function()
                local items = vim.tbl_keys(pick.registry)
                table.sort(items)
                local source = { items = items, name = "Registry", choose = function() end }
                local chosen_picker_name = pick.start({ source = source })
                if chosen_picker_name == nil then
                    return
                end
                return pick.registry[chosen_picker_name]()
            end

            local map = vim.keymap.set

            map("n", "<leader>ff", pick.builtin.files, { desc = "[F]ind [F]iles" })
            map("n", "<leader>fw", pick.builtin.grep_live, { desc = "[F]ind by [W]ord" })
            map("n", "<leader>fcw", function()
                pick.builtin.grep({ pattern = vim.fn.expand("<cword>") })
            end, { desc = "[F]ind [C]urrent [W]ord" })

            -- Buffers picker with <C-d> buffer-wipeout, recipe from
            -- :h MiniPick.builtin.buffers.
            map("n", "<leader><leader>", function()
                local wipeout_cur = function()
                    vim.api.nvim_buf_delete(pick.get_picker_matches().current.bufnr, {})
                end
                local buffer_mappings = { wipeout = { char = "<C-d>", func = wipeout_cur } }
                pick.builtin.buffers({}, { mappings = buffer_mappings })
            end, { desc = "[ ] Find existing buffers" })

            map("n", "<leader>/", function()
                extra.pickers.buf_lines({ scope = "current" })
            end, { desc = "[/] Fuzzily search in current buffer" })

            -- Closest mini equivalent of telescope's "live_grep over open
            -- files": fuzzy matching over the *lines* of all open listed
            -- buffers (buf_lines scope "all") instead of a ripgrep pass
            -- restricted to those files.
            map("n", "<leader>s/", function()
                extra.pickers.buf_lines({ scope = "all" })
            end, { desc = "[S]earch [/] in Open Files" })

            map("n", "<leader>sh", pick.builtin.help, { desc = "[S]earch [H]elp" })
            map("n", "<leader>sk", extra.pickers.keymaps, { desc = "[S]earch [K]eymaps" })
            map("n", "<leader>sd", extra.pickers.diagnostic, { desc = "[S]earch [D]iagnostics" })
            map("n", "<leader>sr", pick.builtin.resume, { desc = "[S]earch [R]esume" })
            map("n", "<leader>s.", extra.pickers.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            map("n", "<leader>sn", function()
                pick.builtin.files(nil, { source = { cwd = vim.fn.stdpath("config") } })
            end, { desc = "[S]earch [N]eovim files" })
            map("n", "<leader>st", pick.registry.registry, { desc = "[S]earch built-in pickers" })
        end,
    },
}

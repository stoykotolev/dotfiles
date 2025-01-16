return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            require("mason-nvim-dap").setup({
                -- Makes a best effort to setup the various debuggers with
                -- reasonable debug configurations
                automatic_setup = true,

                -- You can provide additional configuration to the handlers,
                -- see mason-nvim-dap README for more information
                handlers = {},

                -- You'll need to check that you have the required things installed
                -- online, please don't ask me how to install them :)
                ensure_installed = {
                    -- Update this to ensure that you have the debuggers for the langs you want
                    "delve",
                },
            })

            -- Basic debugging keymaps, feel free to change to your liking!
            vim.keymap.set(
                "n",
                "<leader>dc",
                dap.continue,
                { desc = "[D]ebug: Start/[C]ontinue" }
            )
            vim.keymap.set(
                "n",
                "<leader>dsi",
                dap.step_into,
                { desc = "[D]ebug: [S]tep [I]nto" }
            )
            vim.keymap.set(
                "n",
                "<leader>dso",
                dap.step_over,
                { desc = "[D]ebug: [S]tep [O]ver" }
            )
            vim.keymap.set(
                "n",
                "<leader>dsu",
                dap.step_out,
                { desc = "[D]ebug: [S]tep O[u]t" }
            )
            vim.keymap.set(
                "n",
                "<leader>b",
                dap.toggle_breakpoint,
                { desc = "Debug: Toggle [B]reakpoint" }
            )
            vim.keymap.set("n", "<leader>B", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Debug: Set Breakpoint" })
            dapui.setup({
                icons = {
                    expanded = "▾",
                    collapsed = "▸",
                    current_frame = "*",
                },
                controls = {
                    icons = {
                        pause = "⏸",
                        play = "▶",
                        step_into = "⏎",
                        step_over = "⏭",
                        step_out = "⏮",
                        step_back = "b",
                        run_last = "▶▶",
                        terminate = "⏹",
                        disconnect = "⏏",
                    },
                },
            })

            -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
            vim.keymap.set(
                "n",
                "<leader>du",
                dapui.toggle,
                { desc = "Debug: See last session result." }
            )

            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"] = dapui.close

            -- Install golang specific config
            require("dap-go").setup()
        end,
    },
}

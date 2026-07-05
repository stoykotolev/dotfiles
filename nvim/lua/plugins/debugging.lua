local dap = require("dap")
local dapui = require("dapui")

-- Keymaps (preserved from the old config)
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[D]ebug: Start/[C]ontinue" })
vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "[D]ebug: [S]tep [I]nto" })
vim.keymap.set("n", "<leader>dso", dap.step_over, { desc = "[D]ebug: [S]tep [O]ver" })
vim.keymap.set("n", "<leader>dsu", dap.step_out, { desc = "[D]ebug: [S]tep O[u]t" })
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle [B]reakpoint" })
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

-- Toggle to see last session result. Without this, you can't see session
-- output in case of unhandled exception.
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: See last session result." })

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

require("nvim-dap-virtual-text").setup({})

-- Go: delve via nvim-dap-go (also provides debug-nearest-test)
require("dap-go").setup()

-- JS/TS: js-debug-adapter from Mason
dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
    },
}

for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
    dap.configurations[ft] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch current file (node)",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach to process (node --inspect)",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
        },
    }
end

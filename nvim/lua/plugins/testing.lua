local neotest = require("neotest")

neotest.setup({
    adapters = {
        require("neotest-vitest"),
        require("neotest-golang")({ dap_go_enabled = true }),
        require("neotest-playwright").adapter({
            options = {
                persist_project_selection = true,
                enable_dynamic_test_discovery = true,
            },
        }),
    },
})

local map = vim.keymap.set

map("n", "<leader>rt", function()
    neotest.run.run()
end, { desc = "[R]un nearest [T]est" })
map("n", "<leader>rT", function()
    neotest.run.run(vim.fn.expand("%"))
end, { desc = "[R]un [T]est file" })
map("n", "<leader>rd", function()
    neotest.run.run({ strategy = "dap" })
end, { desc = "[R]un nearest test in [D]ebugger" })
map("n", "<leader>ro", function()
    neotest.output.open({ enter = true, auto_close = true })
end, { desc = "Test [O]utput" })
map("n", "<leader>rp", function()
    neotest.summary.toggle()
end, { desc = "Test summary [P]anel" })

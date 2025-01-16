return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup()

            vim.keymap.set("n", "<leader>a", function()
                harpoon:list():add()
            end)

            vim.keymap.set("n", "<C-e>", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)

            vim.keymap.set("n", "<leader>h", function()
                harpoon:list():select(1)
            end, {
                desc = "Go to 1st harpoon file",
            })
            vim.keymap.set("n", "<leader>j", function()
                harpoon:list():select(2)
            end, {
                desc = "Go to 2nd harpoon file",
            })
            vim.keymap.set("n", "<leader>k", function()
                harpoon:list():select(3)
            end, {
                desc = "Go to 3rd harpoon file",
            })
            vim.keymap.set("n", "<leader>l", function()
                harpoon:list():select(4)
            end, {
                desc = "Go to 4th harpoon file",
            })
        end,
    },
}

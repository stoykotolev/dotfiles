return {
    -- Project-wide search/replace UI (VISION.md D6, replaces nvim-spectre).
    -- Command-driven (:GrugFar / :GrugFarWithin) — no keymap, matching the
    -- old spectre usage which had none either.
    {
        "MagicDuck/grug-far.nvim",
        cmd = { "GrugFar", "GrugFarWithin" },
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },
    -- Maintained fork of the retired norcalli/nvim-colorizer.lua (VISION.md §4.7).
    {
        "catgoose/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    -- Automatic indent detection (VISION.md D10).
    { "tpope/vim-sleuth" },
}

-- Theme trio on trial (VISION.md D4): kanagawa-dragon boots as default,
-- nightfox (nordfox) and nordic are installed but inactive. Flip the
-- default by moving the colorscheme call, then remove the losers.
return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("kanagawa-dragon")
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
    },
    {
        "AlexvZyl/nordic.nvim",
        lazy = true,
    },
}

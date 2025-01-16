return {
    -- {
    --     "rebelot/kanagawa.nvim",
    --     config = function()
    --         require("kanagawa").setup({
    --             undercurl = true, -- enable undercurls
    --             commentStyle = { italic = true },
    --             functionStyle = {},
    --             keywordStyle = { italic = true },
    --             statementStyle = { bold = true },
    --             typeStyle = {},
    --             transparent = false, -- do not set background color
    --             dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    --             terminalColors = true, -- define vim.g.terminal_color_{0,17}
    --         })
    --         vim.cmd([[colorscheme kanagawa-dragon]])
    --     end,
    -- },
    -- {
    --     "ferdinandrau/lavish.nvim",
    --     priority = 1000,
    --     config = function()
    --         require("lavish").apply()
    --     end,
    -- },
    -- {
    --     "datsfilipe/vesper.nvim",
    --     config = function()
    --         require("vesper").setup({
    --             transparent = true,
    --             italics = {
    --                 keywords = false,
    --                 functions = false,
    --                 strings = false,
    --                 variables = false,
    --             },
    --         })
    --         vim.cmd([[colorscheme vesper]])
    --     end,
    -- },
    -- {
    --     "sho-87/kanagawa-paper.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function()
    --         vim.cmd("colorscheme kanagawa-paper")
    --     end
    -- }

    {
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('nordic').load()
        end
    }
}

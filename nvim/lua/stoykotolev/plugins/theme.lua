return {
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = false, -- do not set background color
                dimInactive = false, -- dim inactive window `:h hl-NormalNC`
                terminalColors = true, -- define vim.g.terminal_color_{0,17}
            })
            vim.cmd([[colorscheme kanagawa-dragon]])
        end,
    },
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "regex",
                "vim",
                -- General programing
                "vimdoc",
                "dockerfile",
                "bash",
                "rust",
                "go",
                "json",
                "yaml",
            },
            auto_install = true,
            highlight = {
                enable = true,
            },
            autotag = {
                enable = true,
            },
        },
        config = function(_, tsopts)
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup(tsopts)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup()
        end,
    },
}

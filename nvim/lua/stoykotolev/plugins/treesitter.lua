return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            'windwp/nvim-ts-autotag',
            'axelvc/template-string.nvim',
        },
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
                -- Webdev
                "tsx",
                "typescript",
                "javascript",
                "html",
                "css",
                "graphql",
            },
            auto_install = true,
            highlight = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<enter>',
                    node_incremental = '<enter>',
                    scope_incremental = false,
                    node_decremental = '<bs>',
                },
            },

        },
        config = function(_, tsopts)
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup(tsopts)
            require("template-string").setup({
                filetypes = { 'html', 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
                jsx_brackets = true,
            })
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                max_lines = 1
            })
        end,
    },
}

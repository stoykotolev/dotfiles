-- All plugins are managed by the native vim.pack (nvim 0.12).
-- Updates: `:lua vim.pack.update()` — review the diff buffer, confirm or discard.
-- The lockfile (nvim-pack-lock.json) lives next to init.lua and is committed.

-- Build hooks must be registered before vim.pack.add() so they also run on
-- the initial install.
vim.api.nvim_create_autocmd("PackChanged", {
    group = vim.api.nvim_create_augroup("pack-build-hooks", { clear = true }),
    callback = function(ev)
        if ev.data.kind == "delete" then
            return
        end
        if ev.data.spec.name == "telescope-fzf-native.nvim" then
            vim.system({ "make" }, { cwd = ev.data.path }):wait()
        end
    end,
})

vim.pack.add({
    -- Theme
    "https://github.com/AlexvZyl/nordic.nvim",

    -- Treesitter (main branch: new API, per-filetype vim.treesitter.start)
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
    "https://github.com/windwp/nvim-ts-autotag",
    "https://github.com/axelvc/template-string.nvim",
    "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",

    -- LSP
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/folke/lazydev.nvim",

    -- Completion
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
    "https://github.com/rafamadriz/friendly-snippets",

    -- Formatting / linting
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/mfussenegger/nvim-lint",

    -- Navigation
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
    "https://github.com/stevearc/oil.nvim",

    -- Editing
    "https://github.com/echasnovski/mini.nvim",

    -- Git
    "https://github.com/lewis6991/gitsigns.nvim",

    -- UI
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",

    -- Testing
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/nvim-neotest/neotest",
    "https://github.com/marilari88/neotest-vitest",
    "https://github.com/fredrikaverpil/neotest-golang",
    "https://github.com/thenbe/neotest-playwright",

    -- Debugging
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/theHamsta/nvim-dap-virtual-text",
    "https://github.com/leoluz/nvim-dap-go",
}, { confirm = false })

-- Treesitter (`main` branch rewrite) + companions (VISION.md §4.2, §4.5, D5, D7).

-- Grammar list from VISION.md §4.2 (old list minus rust).
local ensure_installed = {
    "astro",
    "bash",
    "css",
    "dockerfile",
    "go",
    "graphql",
    "html",
    "javascript",
    "json",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "regex",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
}

-- Skip treesitter in very large files, where parse cost outweighs the value.
local max_filesize = 1024 * 1024 -- 1 MiB
local function too_big(buf)
    local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
    return stat ~= nil and stat.size > max_filesize
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            -- Async and idempotent: no-op for grammars already at the locked revision.
            require("nvim-treesitter").install(ensure_installed)

            vim.api.nvim_create_autocmd("FileType", {
                desc = "Treesitter highlighting, folds and incremental selection",
                group = vim.api.nvim_create_augroup("treesitter-attach", { clear = true }),
                callback = function(args)
                    -- Probe parser availability explicitly rather than
                    -- pcall(vim.treesitter.start): a blind pcall would also
                    -- swallow real errors (e.g. broken queries) as "no parser".
                    local lang = vim.treesitter.language.get_lang(args.match)
                    local has_parser = lang ~= nil
                        and vim.treesitter.language.add(lang) ~= nil
                        and not too_big(args.buf)

                    if has_parser then
                        vim.treesitter.start(args.buf, lang)
                    end

                    -- Native folds (VISION.md D5): treesitter expr where a parser
                    -- exists, indent otherwise. Folds stay open by default via
                    -- foldenable/foldlevel in options.lua.
                    if vim.api.nvim_get_current_buf() == args.buf then
                        if has_parser then
                            vim.wo[0][0].foldmethod = "expr"
                            vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                        else
                            vim.wo[0][0].foldmethod = "indent"
                        end
                    end

                    -- Incremental selection (VISION.md §4.5): <Enter> / <BS>.
                    if has_parser then
                        require("config.treeselect").attach(args.buf)
                    end
                end,
            })
        end,
    },

    -- Sticky context line at the top of the window (VISION.md §4.7).
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        opts = { max_lines = 1 },
    },

    -- Auto-close/rename HTML-style tags in html/jsx/tsx/astro (VISION.md §4.7).
    {
        "windwp/nvim-ts-autotag",
        ft = { "html", "javascriptreact", "typescriptreact", "astro" },
        opts = {},
    },

    -- Auto-backtick template strings when typing ${} (VISION.md §4.7).
    {
        "axelvc/template-string.nvim",
        ft = { "html", "typescript", "javascript", "typescriptreact", "javascriptreact", "astro" },
        opts = {
            filetypes = { "html", "typescript", "javascript", "typescriptreact", "javascriptreact", "astro" },
            jsx_brackets = true,
        },
    },

    -- JSX/TSX-aware commentstring for the built-in gc commands (VISION.md D7).
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        opts = {},
    },
}

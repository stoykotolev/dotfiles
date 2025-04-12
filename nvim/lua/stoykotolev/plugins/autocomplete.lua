return {
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = 'default',
                ["<C-j>"] = { 'select_next', 'fallback' },
                ["<C-k>"] = { 'select_prev', 'fallback' },
                ["<C-n>"] = { 'show', 'fallback' },
            },
            appearance = {
                nerd_font_variant = 'mono',
                use_nvim_cmp_as_default = true,
            },
            completion = {
                documentation = {
                    auto_show = true
                },
                menu = {
                    draw = {
                        columns = {
                            { "label",     "label_description", gap = 1 },
                            { "kind_icon", "kind" }
                        },
                    }
                }
            },
            signature = { enabled = true },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    }
}

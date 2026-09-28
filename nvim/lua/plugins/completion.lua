require("blink.cmp").setup({
    keymap = {
        preset = "default",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "show", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
    },
    appearance = {
        nerd_font_variant = "mono",
    },
    completion = {
        trigger = {
            show_on_insert_on_trigger_character = false,
        },
        documentation = {
            auto_show = true,
        },
        accept = {
            auto_brackets = { enabled = false },
        },
        menu = {
            draw = {
                columns = {
                    { "label", "label_description", gap = 1 },
                    { "kind_icon", "kind" },
                },
            },
        },
    },
    signature = { enabled = true },
    sources = {
        default = { "lsp", "path", "snippets", "buffer", "lazydev", "env" },
        providers = {
            env = {
                name = "Env",
                module = "core.blink-env",
            },
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
            },
        },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
})

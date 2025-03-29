return {
    -- {
    --     "hrsh7th/nvim-cmp",
    --     event = "InsertEnter",
    --     dependencies = {
    --         -- Snippet Engine & its associated nvim-cmp source
    --         {
    --             "L3MON4D3/LuaSnip",
    --             build = (function()
    --                 if
    --                     vim.fn.has("win32") == 1
    --                     or vim.fn.executable("make") == 0
    --                 then
    --                     return
    --                 end
    --                 return "make install_jsregexp"
    --             end)(),
    --             dependencies = {
    --                 {
    --                     "rafamadriz/friendly-snippets",
    --                     config = function()
    --                         require("luasnip.loaders.from_vscode").lazy_load()
    --                     end,
    --                 },
    --             },
    --         },
    --         "saadparwaiz1/cmp_luasnip",
    --         "hrsh7th/cmp-nvim-lsp",
    --         "hrsh7th/cmp-path",
    --         "onsails/lspkind.nvim",
    --     },
    --     config = function()
    --         local cmp = require("cmp")
    --         local luasnip = require("luasnip")
    --         local lspkind = require("lspkind")
    --         luasnip.config.setup({})
    --
    --         cmp.setup({
    --             snippet = {
    --                 expand = function(args)
    --                     luasnip.lsp_expand(args.body)
    --                 end,
    --             },
    --             completion = { completeopt = "menu,menuone,noinsert" },
    --             window = {
    --                 completion = {
    --                     col_offset = -3, -- align the abbr and word on cursor (due to fields order below)
    --                 },
    --             },
    --
    --             formatting = {
    --                 fields = { "kind", "abbr", "menu" },
    --                 format = lspkind.cmp_format({
    --                     mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    --                     maxwidth = 50,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    --                     menu = {              -- showing type in menu
    --                         nvim_lsp = "[LSP]",
    --                         path = "[Path]",
    --                         buffer = "[Buffer]",
    --                         luasnip = "[LuaSnip]",
    --                     },
    --                 }),
    --             },
    --             sources = {
    --                 { name = "nvim_lsp" },
    --                 { name = "luasnip" },
    --                 { name = "path" },
    --             },
    --         })
    --     end,
    -- },
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
            },
            appearance = {
                nerd_font_variant = 'mono',
                use_nvim_cmp_as_default = true,
            },
            completion = {
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    }
}

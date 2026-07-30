local autocmd = vim.api.nvim_create_autocmd

-- Buffer-local keymaps + document highlight, on every attached server
autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local lsp_map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        local builtin = require("telescope.builtin")

        -- Goto pickers: tsserver reports library .d.ts sites alongside your
        -- own code, so prefer project results — but fall back to the library
        -- ones when they're all there is (e.g. gd on createServerFn itself).
        local goto_prefer_project = function(lsp_goto)
            return function()
                lsp_goto({
                    on_list = function(options)
                        local project = vim.tbl_filter(function(item)
                            return not item.filename:find("node_modules", 1, true)
                        end, options.items)
                        local items = #project > 0 and project or options.items
                        if #items == 0 then
                            return
                        end
                        vim.fn.setqflist({}, " ", { title = options.title, items = items })
                        if #items == 1 then
                            vim.cmd.cfirst()
                        else
                            builtin.quickfix()
                        end
                    end,
                })
            end
        end

        lsp_map("gd", goto_prefer_project(vim.lsp.buf.definition), "[G]oto [D]efinition")
        lsp_map("gr", builtin.lsp_references, "[G]oto [R]eferences")
        lsp_map("gI", goto_prefer_project(vim.lsp.buf.implementation), "[G]oto [I]mplementation")
        lsp_map("<leader>D", goto_prefer_project(vim.lsp.buf.type_definition), "Type [D]efinition")
        lsp_map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
        lsp_map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        lsp_map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        lsp_map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        lsp_map("K", vim.lsp.buf.hover, "Hover Documentation")
        lsp_map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- Highlight references of the word under the cursor while it rests
        -- there; clear them when it moves.
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/documentHighlight") then
            autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
            })
            autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})

-- Sane lua_ls setup for editing this config; makes vim.* fully known
require("lazydev").setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
})

-- Server configs: nvim-lspconfig ships the defaults (cmd, filetypes, root
-- markers); everything below is merged on top of them.
vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config("vtsls", {
    settings = {
        typescript = {
            preferences = { importModuleSpecifierPreference = "non-relative" },
            updateImportsOnFileMove = { enabled = "always" },
        },
        javascript = {
            preferences = { importModuleSpecifierPreference = "non-relative" },
        },
    },
})

vim.lsp.config("tailwindcss", {
    settings = {
        tailwindCSS = {
            classFunctions = { "cva", "cx" },
        },
    },
})

vim.lsp.config("gopls", {
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            gofumpt = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
})

vim.lsp.config("yamlls", {
    settings = {
        yaml = {
            schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
            schemas = {
                kubernetes = {
                    "k8s/**/*.{yml,yaml}",
                    "manifests/**/*.{yml,yaml}",
                    "*.k8s.{yml,yaml}",
                    "kustomization.{yml,yaml}",
                    "deployment*.{yml,yaml}",
                    "service*.{yml,yaml}",
                },
            },
        },
    },
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace",
            },
            diagnostics = { disable = { "missing-fields" } },
        },
    },
})

vim.lsp.enable({
    "vtsls",
    "eslint", -- only attaches in projects with an eslint config (root markers)
    "tailwindcss",
    "gopls",
    "yamlls",
    "dockerls",
    "lua_ls",
})

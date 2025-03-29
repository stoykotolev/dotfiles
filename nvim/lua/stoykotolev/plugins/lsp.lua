local autocmd = vim.api.nvim_create_autocmd
return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            'saghen/blink.cmp',
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            {
                "j-hui/fidget.nvim",
                opts = {
                    notification = {
                        window = {
                            winblend = 0
                        }
                    }
                }
            },

            { "folke/neodev.nvim", opts = {} },
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup(
                    "kickstart-lsp-attach",
                    { clear = true }
                ),
                callback = function(event)
                    local lsp_map = function(keys, func, desc)
                        vim.keymap.set(
                            "n",
                            keys,
                            func,
                            { buffer = event.buf, desc = "LSP: " .. desc }
                        )
                    end
                    lsp_map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
                    lsp_map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
                    lsp_map(
                        "gI",
                        vim.lsp.buf.implementation,
                        "[G]oto [I]mplementation"
                    )
                    lsp_map(
                        "<leader>D",
                        vim.lsp.buf.type_definition,
                        "Type [D]efinition"
                    )
                    lsp_map(
                        "<leader>ds",
                        vim.lsp.buf.document_symbol,
                        "[D]ocument [S]ymbols"
                    )
                    lsp_map(
                        "<leader>ws",
                        vim.lsp.buf.workspace_symbol,
                        "[W]orkspace [S]ymbols"
                    )
                    lsp_map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    lsp_map(
                        "<leader>ca",
                        vim.lsp.buf.code_action,
                        "[C]ode [A]ction"
                    )
                    lsp_map("K", vim.lsp.buf.hover, "Hover Documentation")
                    lsp_map(
                        "gD",
                        vim.lsp.buf.declaration,
                        "[G]oto [D]eclaration"
                    )

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client =
                        vim.lsp.get_client_by_id(event.data.client_id)
                    if
                        client
                        and client.server_capabilities.documentHighlightProvider
                    then
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

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend(
                "force",
                capabilities,
                require('blink.cmp').get_lsp_capabilities()
            )
            local servers = {
                graphql = {
                    filetypes = {
                        'graphql',
                        'gql',
                    },
                    capabilities = capabilities,
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            diagnostics = { disable = { "missing-fields" } },
                        },
                    },
                },
                gopls = {
                    capabilities = capabilities,
                    cmd = { "gopls" },
                    filetypes = { "go", "gomod", "gowork", "gotmpl" },
                    root_dir = require("lspconfig/util").root_pattern(
                        "go.work",
                        "go.mod"
                    ),
                    settings = {
                        gopls = {
                            completeUnimported = true,
                            usePlaceholders = true,
                            analyses = {
                                unusedparams = true,
                            },
                        },
                    },
                },
                html = {
                    capabilities = capabilities,
                    filetypes = {
                        "html",
                        "css",
                        "javascriptreact",
                        "typescriptreact",
                        "javascript",
                        "typescript",
                        "jsx",
                        "tsx",
                    },
                },
                emmet_language_server = {
                    capabilities = capabilities,
                    filetypes = {
                        "html",
                        "css",
                        "javascriptreact",
                        "typescriptreact",
                        "javascript",
                        "typescript",
                        "jsx",
                        "tsx",
                        "markdown",
                    },
                },
                tailwindcss = {
                    capabilities = capabilities,
                    filetypes = {
                        "html",
                        "css",
                        "javascriptreact",
                        "typescriptreact",
                        "javascript",
                        "typescript",
                        "jsx",
                        "tsx",
                    },
                    root_dir = require("lspconfig").util.root_pattern(
                        "tailwind.config.js",
                        "tailwind.config.cjs",
                        "tailwind.config.mjs",
                        "tailwind.config.ts",
                        "postcss.config.js",
                        "postcss.config.cjs",
                        "postcss.config.mjs",
                        "postcss.config.ts",
                        "package.json",
                        "node_modules",
                        ".git"
                    ),
                },
                marksman = {},
            }

            require("mason").setup()

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                "markdownlint",
                "biome",
                "stylua",
                "jsonls",
                "prettierd",
                "eslint_d",
                "golangci-lint",
                "delve",
                "dockerfile-language-server",
                "helm-ls",
                "yaml-language-server",
                "gofumpt",
                "golines",
                "goimports-reviser",
                "lua-language-server",
            })

            require("mason-tool-installer").setup({
                ensure_installed = ensure_installed,
            })

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for tsserver)
                        server.capabilities = vim.tbl_deep_extend(
                            "force",
                            {},
                            capabilities,
                            server.capabilities or {}
                        )
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^4", -- Recommended
        ft = { "rust" },
    },
    {
        'pmizio/typescript-tools.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
        config = function()
            local api = require 'typescript-tools.api'
            require('typescript-tools').setup {
                handlers = {
                    ['textDocument/publishDiagnostics'] = api.filter_diagnostics { 6133 },
                },
                settings = {
                    tsserver_file_preferences = {
                        importModuleSpecifierPreference = 'non-relative',
                    },
                },
            }
            local autocmd = vim.api.nvim_create_autocmd
            autocmd('BufWritePre', {
                pattern = '*.ts,*.tsx,*.jsx,*.js',
                callback = function(args)
                    vim.cmd 'TSToolsAddMissingImports sync'
                    vim.cmd 'TSToolsOrganizeImports sync'
                    require('conform').format { bufnr = args.buf }
                end,
            })
        end,

    },
    {
        "olexsmir/gopher.nvim",
        ft = "go",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { "<leader>gsj", "<cmd>GoTagAdd json<CR>", desc = "Add [J]son tags for [G]o [S]tructs" },
            { "<leader>gsy", "<cmd>GoTagAdd yaml<CR>", desc = "Add [J]son tags for [G]o [S]tructs" }
        },
        -- (optional) will update plugin's deps on every update
        build = function()
            vim.cmd.GoInstallDeps()
        end,
        ---@type gopher.Config
        opts = {
            gotag = {
                transform = "camelcase",
            },
        },
    }
}

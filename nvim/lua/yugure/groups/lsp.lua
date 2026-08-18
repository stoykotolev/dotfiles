-- LSP semantic tokens, diagnostics, and LSP UI.
return function(p)
    return {
        -- Semantic tokens sit at extmark priority 125 vs treesitter's 100,
        -- so @lsp.* wins wherever both fire. Clear (`{}`, NOT a link — only
        -- empty attrs let the lower-priority treesitter highlight through)
        -- the types treesitter already gets right; define only server-only
        -- knowledge.
        ["@lsp.type.variable"] = {},
        ["@lsp.type.property"] = {},
        ["@lsp.type.parameter"] = {},
        ["@lsp.type.function"] = {},
        ["@lsp.type.method"] = {},
        ["@lsp.type.keyword"] = {},
        ["@lsp.type.operator"] = {},
        ["@lsp.type.string"] = {},
        ["@lsp.type.number"] = {},
        ["@lsp.type.comment"] = {},

        ["@lsp.type.class"] = { fg = p.teal },
        ["@lsp.type.interface"] = { fg = p.teal },
        ["@lsp.type.struct"] = { fg = p.teal },
        ["@lsp.type.enum"] = { fg = p.teal },
        ["@lsp.type.type"] = { fg = p.teal },
        ["@lsp.type.typeParameter"] = { fg = p.teal, italic = true },
        ["@lsp.type.enumMember"] = { fg = p.iris },
        ["@lsp.type.namespace"] = { fg = p.iris }, -- gopls package names
        ["@lsp.type.decorator"] = { fg = p.iris },
        ["@lsp.type.macro"] = { fg = p.iris },
        ["@lsp.type.event"] = { fg = p.iris },
        ["@lsp.type.modifier"] = { fg = p.rose },
        ["@lsp.type.regexp"] = { link = "@string.regexp" },

        ["@lsp.typemod.variable.defaultLibrary"] = {
            fg = p.iris,
            italic = true,
        },
        ["@lsp.typemod.function.defaultLibrary"] = {
            fg = p.foam,
            italic = true,
        },
        -- vtsls tags essentially every `const` as readonly; colouring it
        -- would flood TypeScript files gold. Opt back in with:
        -- ["@lsp.typemod.variable.readonly"] = { fg = p.gold },
        ["@lsp.typemod.variable.readonly"] = {},
        ["@lsp.typemod.property.readonly"] = {},
        ["@lsp.mod.deprecated"] = { link = "DiagnosticDeprecated" },

        -- Diagnostics
        DiagnosticError = { fg = p.love },
        DiagnosticWarn = { fg = p.gold },
        DiagnosticInfo = { fg = p.foam },
        DiagnosticHint = { fg = p.teal },
        DiagnosticOk = { fg = p.teal },

        DiagnosticUnderlineError = { undercurl = true, sp = p.love },
        DiagnosticUnderlineWarn = { undercurl = true, sp = p.gold },
        DiagnosticUnderlineInfo = { undercurl = true, sp = p.foam },
        DiagnosticUnderlineHint = { undercurl = true, sp = p.teal },
        DiagnosticUnderlineOk = { undercurl = true, sp = p.teal },

        DiagnosticVirtualTextError = { fg = p.love, bg = "#2A1E24" },
        DiagnosticVirtualTextWarn = { fg = p.gold, bg = "#2A2419" },
        DiagnosticVirtualTextInfo = { fg = p.foam, bg = "#1B2530" },
        DiagnosticVirtualTextHint = { fg = p.teal, bg = "#1B262A" },
        DiagnosticVirtualTextOk = { link = "DiagnosticVirtualTextHint" },

        -- virtual_lines.current_line is enabled; full-line backgrounds, so
        -- these must stay dimmer than the virtual-text ones.
        DiagnosticVirtualLinesError = { fg = p.love, bg = "#221A1F" },
        DiagnosticVirtualLinesWarn = { fg = p.gold, bg = "#221F18" },
        DiagnosticVirtualLinesInfo = { fg = p.foam, bg = "#1A212B" },
        DiagnosticVirtualLinesHint = { fg = p.teal, bg = "#1A2226" },
        DiagnosticVirtualLinesOk = { link = "DiagnosticVirtualLinesHint" },

        DiagnosticFloatingError = { link = "DiagnosticError" },
        DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
        DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
        DiagnosticFloatingHint = { link = "DiagnosticHint" },
        DiagnosticFloatingOk = { link = "DiagnosticOk" },
        DiagnosticSignError = { link = "DiagnosticError" },
        DiagnosticSignWarn = { link = "DiagnosticWarn" },
        DiagnosticSignInfo = { link = "DiagnosticInfo" },
        DiagnosticSignHint = { link = "DiagnosticHint" },
        DiagnosticSignOk = { link = "DiagnosticOk" },
        DiagnosticDeprecated = { strikethrough = true, sp = p.muted },
        -- Not a Comment link — must not italicise the dimmed code.
        DiagnosticUnnecessary = { fg = p.muted },

        -- LSP UI
        LspReferenceText = { bg = p.high },
        LspReferenceRead = { bg = p.high },
        LspReferenceWrite = { bg = p.high, underline = true },
        LspSignatureActiveParameter = {
            fg = p.gold,
            bg = p.med,
            bold = true,
        },
        LspInlayHint = { fg = p.faint, bg = p.low, italic = true },
        LspCodeLens = { fg = p.muted, italic = true },
        LspCodeLensSeparator = { fg = p.faint },
        LspInfoBorder = { link = "FloatBorder" },
    }
end

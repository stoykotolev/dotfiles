-- Treesitter @ captures. Direct values rather than links to legacy groups:
-- :Inspect resolves each capture to its own definition, and the treesitter
-- palette stays decoupled from the no-parser fallback palette.
return function(p)
    return {
        -- Identifiers
        ["@variable"] = { fg = p.text },
        ["@variable.builtin"] = { fg = p.rose, italic = true },
        ["@variable.parameter"] = { fg = p.iron, italic = true },
        ["@variable.parameter.builtin"] = {
            fg = p.iron,
            italic = true,
            bold = true,
        },
        ["@variable.member"] = { fg = p.iron },
        ["@property"] = { fg = p.iron },
        ["@field"] = { link = "@variable.member" }, -- legacy alias
        ["@parameter"] = { link = "@variable.parameter" }, -- legacy alias

        -- Literals
        ["@constant"] = { fg = p.gold },
        ["@constant.builtin"] = { fg = p.iris, bold = true },
        ["@constant.macro"] = { fg = p.iris },
        ["@string"] = { fg = p.gold },
        ["@string.documentation"] = { fg = p.gold, italic = true },
        ["@string.escape"] = { fg = p.gold, bold = true },
        ["@string.regexp"] = { fg = p.teal },
        ["@string.special"] = { fg = p.iris },
        ["@string.special.symbol"] = { fg = p.iris },
        ["@string.special.path"] = { fg = p.gold, underline = true },
        ["@string.special.url"] = { fg = p.foam, underline = true },
        ["@character"] = { fg = p.gold },
        ["@character.special"] = { fg = p.iris },
        ["@number"] = { fg = p.iris },
        ["@number.float"] = { fg = p.iris },
        ["@boolean"] = { fg = p.iris },

        -- Types & modules
        ["@type"] = { fg = p.teal },
        ["@type.builtin"] = { fg = p.teal, italic = true },
        ["@type.definition"] = { fg = p.teal, bold = true },
        ["@type.qualifier"] = { fg = p.rose },
        ["@constructor"] = { fg = p.teal },
        ["@module"] = { fg = p.iris },
        ["@module.builtin"] = { fg = p.iris, italic = true },
        ["@namespace"] = { link = "@module" }, -- legacy alias
        ["@label"] = { fg = p.rose },
        ["@attribute"] = { fg = p.iris },
        ["@attribute.builtin"] = { fg = p.iris, italic = true },

        -- Functions
        ["@function"] = { fg = p.foam },
        ["@function.builtin"] = { fg = p.foam, italic = true },
        ["@function.call"] = { fg = p.foam },
        ["@function.macro"] = { fg = p.iris },
        ["@function.method"] = { fg = p.foam },
        ["@function.method.call"] = { fg = p.foam },
        ["@method"] = { link = "@function.method" }, -- legacy alias
        ["@method.call"] = { link = "@function.method.call" }, -- legacy alias

        -- Keywords — the rose family, the scheme's signature
        ["@keyword"] = { fg = p.rose },
        ["@keyword.coroutine"] = { fg = p.rose, italic = true },
        ["@keyword.function"] = { fg = p.rose },
        ["@keyword.operator"] = { fg = p.rose },
        ["@keyword.import"] = { fg = p.rose, italic = true },
        ["@keyword.type"] = { fg = p.rose },
        ["@keyword.modifier"] = { fg = p.rose },
        ["@keyword.repeat"] = { fg = p.rose },
        ["@keyword.return"] = { fg = p.rose, bold = true },
        ["@keyword.debug"] = { fg = p.love },
        ["@keyword.exception"] = { fg = p.rose, bold = true },
        ["@keyword.conditional"] = { fg = p.rose },
        ["@keyword.conditional.ternary"] = { fg = p.rose },
        ["@keyword.directive"] = { fg = p.iris },
        ["@keyword.directive.define"] = { fg = p.iris },
        ["@conditional"] = { link = "@keyword.conditional" }, -- legacy alias
        ["@repeat"] = { link = "@keyword.repeat" }, -- legacy alias
        ["@include"] = { link = "@keyword.import" }, -- legacy alias
        ["@exception"] = { link = "@keyword.exception" }, -- legacy alias
        ["@define"] = { link = "@keyword.directive.define" }, -- legacy alias
        ["@preproc"] = { link = "@keyword.directive" }, -- legacy alias
        ["@storageclass"] = { link = "@keyword.modifier" }, -- legacy alias

        -- Operators & punctuation
        ["@operator"] = { fg = p.subtle },
        ["@punctuation.delimiter"] = { fg = p.muted },
        ["@punctuation.bracket"] = { fg = p.subtle },
        -- ${} interpolation; pairs with template-string.nvim
        ["@punctuation.special"] = { fg = p.rose },

        -- Comments — must match todo-comments so TODO: reads correctly
        ["@comment"] = { fg = p.muted, italic = true },
        ["@comment.documentation"] = { fg = p.muted, italic = true },
        ["@comment.error"] = { fg = p.love, bold = true },
        ["@comment.warning"] = { fg = p.gold, bold = true },
        ["@comment.todo"] = { fg = p.base, bg = p.gold, bold = true },
        ["@comment.note"] = { fg = p.base, bg = p.foam, bold = true },

        -- Tags (TSX/HTML)
        ["@tag"] = { fg = p.teal },
        ["@tag.builtin"] = { fg = p.teal },
        ["@tag.attribute"] = { fg = p.iris },
        ["@tag.delimiter"] = { fg = p.muted },

        -- Diff filetype
        ["@diff.plus"] = { fg = p.teal },
        ["@diff.minus"] = { fg = p.love },
        ["@diff.delta"] = { fg = p.gold },

        -- Misc
        ["@none"] = {},
        ["@conceal"] = { fg = p.muted },
        ["@error"] = { fg = p.love },
        ["@spell"] = {},
        ["@nospell"] = {},
    }
end

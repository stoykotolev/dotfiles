-- @markup.* — used by both the markdown treesitter grammar and
-- render-markdown.
return function(p)
    return {
        ["@markup.strong"] = { bold = true },
        ["@markup.italic"] = { italic = true },
        ["@markup.strikethrough"] = { strikethrough = true },
        ["@markup.underline"] = { underline = true },

        ["@markup.heading"] = { fg = p.gold, bold = true },
        ["@markup.heading.1"] = { fg = p.rose, bold = true },
        ["@markup.heading.2"] = { fg = p.gold, bold = true },
        ["@markup.heading.3"] = { fg = p.foam, bold = true },
        ["@markup.heading.4"] = { fg = p.teal, bold = true },
        ["@markup.heading.5"] = { fg = p.iris, bold = true },
        ["@markup.heading.6"] = { fg = p.subtle, bold = true },

        ["@markup.quote"] = { fg = p.muted, italic = true },
        ["@markup.math"] = { fg = p.iris },
        ["@markup.link"] = { fg = p.foam },
        ["@markup.link.label"] = { fg = p.teal },
        ["@markup.link.url"] = { fg = p.muted, underline = true },
        ["@markup.raw"] = { fg = p.teal, bg = p.surface },
        ["@markup.raw.block"] = { bg = p.surface },
        ["@markup.list"] = { fg = p.rose },
        ["@markup.list.checked"] = { fg = p.teal },
        ["@markup.list.unchecked"] = { fg = p.muted },
        ["@markup.environment"] = { fg = p.iris },

        -- Legacy @text.* aliases
        ["@text.title"] = { link = "@markup.heading" },
        ["@text.literal"] = { link = "@markup.raw" },
        ["@text.uri"] = { link = "@markup.link.url" },
        ["@text.reference"] = { link = "@markup.link" },
        ["@text.strong"] = { link = "@markup.strong" },
        ["@text.emphasis"] = { link = "@markup.italic" },
        ["@text.todo"] = { link = "@comment.todo" },
        ["@text.note"] = { link = "@comment.note" },
        ["@text.warning"] = { link = "@comment.warning" },
        ["@text.danger"] = { link = "@comment.error" },
    }
end

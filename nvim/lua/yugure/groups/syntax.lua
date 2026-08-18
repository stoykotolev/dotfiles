-- Legacy syntax groups. Real values, not links to @ captures — these are
-- the fallback for filetypes with no parser (gitcommit, fish, conf, man).
return function(p)
    return {
        Comment = { fg = p.muted, italic = true },

        Constant = { fg = p.gold },
        String = { fg = p.gold },
        Character = { fg = p.gold },
        Number = { fg = p.iris },
        Boolean = { fg = p.iris },
        Float = { link = "Number" },

        Identifier = { fg = p.text },
        Function = { fg = p.foam },

        Statement = { fg = p.rose },
        Conditional = { fg = p.rose },
        Repeat = { fg = p.rose },
        Label = { fg = p.rose },
        Operator = { fg = p.subtle },
        Keyword = { fg = p.rose },
        Exception = { fg = p.rose, bold = true },

        PreProc = { fg = p.iris },
        Include = { fg = p.rose },
        Define = { fg = p.iris },
        Macro = { fg = p.iris },
        PreCondit = { fg = p.iris },

        Type = { fg = p.teal },
        StorageClass = { fg = p.rose },
        Structure = { fg = p.teal },
        Typedef = { fg = p.teal },

        Special = { fg = p.iris },
        SpecialChar = { fg = p.gold, bold = true },
        Tag = { fg = p.teal },
        Delimiter = { fg = p.subtle },
        SpecialComment = { fg = p.subtle, italic = true },
        Debug = { fg = p.love },

        Underlined = { underline = true },
        Ignore = { fg = p.faint },
        Error = { fg = p.love, bg = p.err_bg },
        Todo = { fg = p.base, bg = p.gold, bold = true },

        Bold = { bold = true },
        Italic = { italic = true },
    }
end

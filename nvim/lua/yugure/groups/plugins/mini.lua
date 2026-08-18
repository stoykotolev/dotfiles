-- mini.statusline + mini.surround are the used modules; MiniIcons* is a
-- hedge mapping mini.icons' default hues to the nearest palette colours.
return function(p)
    return {
        MiniStatuslineModeNormal = { fg = p.base, bg = p.foam, bold = true },
        MiniStatuslineModeInsert = { fg = p.base, bg = p.teal, bold = true },
        MiniStatuslineModeVisual = { fg = p.base, bg = p.iris, bold = true },
        MiniStatuslineModeReplace = { fg = p.base, bg = p.love, bold = true },
        MiniStatuslineModeCommand = { fg = p.base, bg = p.gold, bold = true },
        MiniStatuslineModeOther = { fg = p.base, bg = p.rose, bold = true },
        MiniStatuslineDevinfo = { fg = p.subtle, bg = p.surface },
        MiniStatuslineFilename = { fg = p.muted, bg = p.low },
        MiniStatuslineFileinfo = { fg = p.subtle, bg = p.surface },
        MiniStatuslineInactive = { link = "StatusLineNC" },
        MiniSurround = { fg = p.base, bg = p.gold },

        MiniIconsAzure = { fg = p.foam },
        MiniIconsBlue = { fg = p.foam },
        MiniIconsCyan = { fg = p.teal },
        MiniIconsGreen = { fg = p.teal },
        MiniIconsGrey = { fg = p.subtle },
        MiniIconsOrange = { fg = p.gold },
        MiniIconsPurple = { fg = p.iris },
        MiniIconsRed = { fg = p.love },
        MiniIconsYellow = { fg = p.gold },

        MasonNormal = { link = "NormalFloat" },
        MasonHeader = { fg = p.base, bg = p.rose, bold = true },
        MasonHeading = { fg = p.text, bold = true },
        MasonHighlight = { fg = p.foam },
        MasonHighlightBlock = { fg = p.base, bg = p.foam },
        MasonMuted = { fg = p.muted },
    }
end

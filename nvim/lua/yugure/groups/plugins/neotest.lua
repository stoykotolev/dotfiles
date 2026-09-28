return function(p)
    return {
        NeotestPassed = { fg = p.teal },
        NeotestFailed = { fg = p.love },
        NeotestRunning = { fg = p.gold },
        NeotestSkipped = { fg = p.muted },
        NeotestUnknown = { fg = p.faint },
        NeotestTest = { fg = p.text },
        NeotestNamespace = { fg = p.iris, bold = true },
        NeotestFile = { fg = p.foam },
        NeotestDir = { fg = p.foam },
        NeotestFocused = { bold = true, underline = true },
        NeotestAdapterName = { fg = p.iris, bold = true },
        NeotestExpandMarker = { fg = p.faint },
        NeotestIndent = { fg = p.faint },
        NeotestMarked = { fg = p.gold, bold = true },
        NeotestWinSelect = { fg = p.foam, bold = true },
        NeotestTarget = { fg = p.rose },
        NeotestWatching = { fg = p.gold },
        NeotestBorder = { link = "FloatBorder" },
    }
end

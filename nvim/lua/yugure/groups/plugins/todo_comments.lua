-- signs = false in the plugin config, so only the Fg/Bg groups matter.
return function(p)
    return {
        TodoBgFIX = { fg = p.base, bg = p.love, bold = true },
        TodoFgFIX = { fg = p.love },
        TodoBgTODO = { fg = p.base, bg = p.foam, bold = true },
        TodoFgTODO = { fg = p.foam },
        TodoBgHACK = { fg = p.base, bg = p.gold, bold = true },
        TodoFgHACK = { fg = p.gold },
        TodoBgWARN = { fg = p.base, bg = p.gold, bold = true },
        TodoFgWARN = { fg = p.gold },
        TodoBgPERF = { fg = p.base, bg = p.iris, bold = true },
        TodoFgPERF = { fg = p.iris },
        TodoBgNOTE = { fg = p.base, bg = p.teal, bold = true },
        TodoFgNOTE = { fg = p.teal },
        TodoBgTEST = { fg = p.base, bg = p.iris, bold = true },
        TodoFgTEST = { fg = p.iris },
    }
end

-- Minimum viable set; Phase 2 fleshes this out.
return function(p)
    return {
        Normal = { fg = p.text, bg = p.base },
        NormalFloat = { fg = p.text, bg = p.surface },
        CursorLine = { bg = p.low },
        Visual = { bg = p.med },
        LineNr = { fg = p.faint },
        CursorLineNr = { fg = p.gold, bold = true },
        Comment = { fg = p.muted, italic = true },
        StatusLine = { fg = p.subtle, bg = p.overlay },
    }
end

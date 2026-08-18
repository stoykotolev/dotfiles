-- Sticky context (max_lines = 1) must read as chrome, not code.
return function(p)
    return {
        TreesitterContext = { bg = p.low },
        TreesitterContextLineNumber = { fg = p.faint, bg = p.low },
        TreesitterContextBottom = { underline = true, sp = p.high },
        TreesitterContextSeparator = { fg = p.high },
        TreesitterContextLineNumberBottom = { underline = true, sp = p.high },
    }
end

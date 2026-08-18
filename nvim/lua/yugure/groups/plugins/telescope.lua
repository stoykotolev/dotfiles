-- Telescope config draws borders as text (custom borderchars), so the
-- *Border groups use fg = the pane's own bg to make borders invisible
-- where the design wants seamless panels. Prompt sits on overlay,
-- results/preview on surface.
return function(p)
    return {
        TelescopeNormal = { fg = p.text, bg = p.surface },
        TelescopeBorder = { fg = p.high, bg = p.surface },
        TelescopeTitle = { fg = p.muted, bg = p.surface },

        TelescopePromptNormal = { fg = p.text, bg = p.overlay },
        TelescopePromptBorder = { fg = p.overlay, bg = p.overlay },
        TelescopePromptTitle = { fg = p.base, bg = p.rose, bold = true },
        TelescopePromptPrefix = { fg = p.rose, bg = p.overlay },
        TelescopePromptCounter = { fg = p.muted, bg = p.overlay },

        TelescopeResultsNormal = { fg = p.subtle, bg = p.surface },
        TelescopeResultsBorder = { fg = p.surface, bg = p.surface },
        TelescopeResultsTitle = { fg = p.surface, bg = p.surface },

        TelescopePreviewNormal = { fg = p.text, bg = p.surface },
        TelescopePreviewBorder = { fg = p.surface, bg = p.surface },
        TelescopePreviewTitle = { fg = p.base, bg = p.teal, bold = true },

        TelescopeSelection = { fg = p.text, bg = p.med, bold = true },
        TelescopeSelectionCaret = { fg = p.rose, bg = p.med },
        TelescopeMultiSelection = { fg = p.iris, bg = p.med },
        TelescopeMultiIcon = { fg = p.iris },
        TelescopeMatching = { fg = p.gold, bold = true },
        TelescopePreviewLine = { bg = p.med },
        TelescopePreviewMatch = { fg = p.base, bg = p.gold },

        TelescopeResultsDiffAdd = { fg = p.teal },
        TelescopeResultsDiffChange = { fg = p.gold },
        TelescopeResultsDiffDelete = { fg = p.love },
        TelescopeResultsComment = { fg = p.muted },
    }
end

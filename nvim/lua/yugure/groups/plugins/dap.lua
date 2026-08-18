-- nvim-dap signs, dap-ui, dap-virtual-text.
return function(p)
    return {
        -- nvim-dap signs
        DapBreakpoint = { fg = p.love },
        DapBreakpointCondition = { fg = p.gold },
        DapLogPoint = { fg = p.foam },
        DapBreakpointRejected = { fg = p.muted },
        DapStopped = { fg = p.gold },
        DapStoppedLine = { bg = "#2A2419" },

        -- dap-ui
        DapUINormal = { link = "NormalFloat" },
        -- lowercase "of" is dap-ui's actual group name
        DapUIEndofBuffer = { fg = p.surface, bg = p.surface },
        DapUIVariable = { fg = p.text },
        DapUIScope = { fg = p.foam, bold = true },
        DapUIType = { fg = p.teal },
        DapUIValue = { fg = p.iron },
        DapUIModifiedValue = { fg = p.gold, bold = true },
        DapUIDecoration = { fg = p.foam },
        DapUIThread = { fg = p.teal },
        DapUIStoppedThread = { fg = p.gold },
        DapUIFrameName = { fg = p.text },
        DapUISource = { fg = p.iris },
        DapUILineNumber = { fg = p.faint },
        DapUICurrentFrameName = { fg = p.teal, bold = true },
        DapUIFloatBorder = { link = "FloatBorder" },
        DapUIWatchesEmpty = { fg = p.muted },
        DapUIWatchesValue = { fg = p.teal },
        DapUIWatchesError = { fg = p.love },
        DapUIBreakpointsPath = { fg = p.foam },
        DapUIBreakpointsInfo = { fg = p.teal },
        DapUIBreakpointsCurrentLine = { fg = p.gold, bold = true },
        DapUIBreakpointsLine = { fg = p.faint },
        DapUIBreakpointsDisabledLine = { fg = p.muted },

        -- dap-ui controls
        DapUIStepOver = { fg = p.foam },
        DapUIStepInto = { fg = p.foam },
        DapUIStepBack = { fg = p.foam },
        DapUIStepOut = { fg = p.foam },
        DapUIRestart = { fg = p.foam },
        DapUIPlayPause = { fg = p.teal },
        DapUIStop = { fg = p.love },
        DapUIUnavailable = { fg = p.muted },
        DapUIStepOverNC = { fg = p.foam, bg = p.surface },
        DapUIStepIntoNC = { fg = p.foam, bg = p.surface },
        DapUIStepBackNC = { fg = p.foam, bg = p.surface },
        DapUIStepOutNC = { fg = p.foam, bg = p.surface },
        DapUIRestartNC = { fg = p.foam, bg = p.surface },
        DapUIPlayPauseNC = { fg = p.teal, bg = p.surface },
        DapUIStopNC = { fg = p.love, bg = p.surface },
        DapUIUnavailableNC = { fg = p.muted, bg = p.surface },
        DapUIWinSelect = { fg = p.gold, bold = true },

        -- dap-virtual-text
        NvimDapVirtualText = { fg = p.faint, italic = true },
        NvimDapVirtualTextChanged = { fg = p.gold, italic = true },
        NvimDapVirtualTextError = { fg = p.love, italic = true },
        NvimDapVirtualTextInfo = { fg = p.foam, italic = true },
    }
end

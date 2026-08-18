return function(p)
    return {
        -- Backgrounds & cursor
        Normal = { fg = p.text, bg = p.base },
        NormalNC = { link = "Normal" }, -- no inactive dimming
        NormalFloat = { fg = p.text, bg = p.surface },
        FloatBorder = { fg = p.high, bg = p.surface },
        FloatTitle = { fg = p.gold, bg = p.surface, bold = true },
        FloatFooter = { fg = p.muted, bg = p.surface },
        Cursor = { fg = p.base, bg = p.text },
        lCursor = { link = "Cursor" },
        CursorIM = { link = "Cursor" },
        TermCursor = { fg = p.base, bg = p.text },
        CursorLine = { bg = p.low },
        CursorColumn = { link = "CursorLine" },
        ColorColumn = { bg = "#232733" },
        Visual = { bg = p.med },
        VisualNOS = { bg = "#262C3C" },

        -- Gutter. SignColumn bg must equal Normal: signcolumn=yes is always
        -- on, a mismatched bg reads as a stripe.
        LineNr = { fg = p.faint },
        LineNrAbove = { link = "LineNr" },
        LineNrBelow = { link = "LineNr" },
        CursorLineNr = { fg = p.gold, bold = true },
        SignColumn = { fg = p.faint, bg = p.base },
        CursorLineSign = { fg = p.faint, bg = p.low },
        FoldColumn = { fg = p.faint, bg = p.base },
        CursorLineFold = { fg = p.muted, bg = p.low },
        Folded = { fg = p.subtle, bg = p.low },

        -- Whitespace / structure (list=true with tab/trail/nbsp is on)
        NonText = { fg = p.faint },
        Whitespace = { fg = "#3E4557" },
        SpecialKey = { fg = p.faint },
        EndOfBuffer = { fg = p.overlay }, -- tildes nearly vanish
        Conceal = { fg = p.muted },
        MatchParen = { fg = p.gold, bg = p.high, bold = true },
        WinSeparator = { fg = p.high, bg = p.base },
        VertSplit = { link = "WinSeparator" },
        Directory = { fg = p.foam },
        Title = { fg = p.gold, bold = true },

        -- Search. IncSearch doubles as the yank flash (vim.hl.on_yank).
        Search = { fg = p.text, bg = p.search_bg },
        IncSearch = { fg = p.base, bg = p.gold, bold = true },
        CurSearch = { fg = p.base, bg = p.gold, bold = true },
        Substitute = { fg = p.base, bg = p.love, bold = true },

        -- Popup menu (base that blink.cmp inherits)
        Pmenu = { fg = p.text, bg = p.surface },
        PmenuSel = { bg = p.med, bold = true },
        PmenuKind = { fg = p.iris, bg = p.surface },
        PmenuKindSel = { fg = p.iris, bg = p.med },
        PmenuExtra = { fg = p.muted, bg = p.surface },
        PmenuExtraSel = { fg = p.muted, bg = p.med },
        PmenuSbar = { bg = p.low },
        PmenuThumb = { bg = p.high },
        PmenuMatch = { fg = p.foam, bold = true },
        PmenuMatchSel = { fg = p.foam, bg = p.med, bold = true },
        ComplMatchIns = { fg = p.muted },
        WildMenu = { link = "PmenuSel" },
        SnippetTabstop = { bg = p.med },

        -- Statusline / tabline / winbar (StatusLine is fill only;
        -- mini.statusline paints sections)
        StatusLine = { fg = p.subtle, bg = p.overlay },
        StatusLineNC = { fg = p.muted, bg = p.surface },
        StatusLineTerm = { link = "StatusLine" },
        StatusLineTermNC = { link = "StatusLineNC" },
        TabLine = { fg = p.muted, bg = p.surface },
        TabLineFill = { bg = p.base },
        TabLineSel = { fg = p.text, bg = p.med, bold = true },
        WinBar = { fg = p.subtle, bg = p.base, bold = true },
        WinBarNC = { fg = p.muted, bg = p.base },

        -- Messages
        ErrorMsg = { fg = p.love, bold = true },
        WarningMsg = { fg = p.gold },
        MoreMsg = { fg = p.teal },
        ModeMsg = { fg = p.text, bold = true },
        Question = { fg = p.foam },
        MsgArea = { fg = p.text },
        MsgSeparator = { fg = p.high, bg = p.surface },
        QuickFixLine = { bg = p.med, bold = true },

        -- Diff (inccommand=split, gitsigns previews)
        DiffAdd = { bg = p.git_add_bg },
        DiffChange = { bg = p.git_change_bg },
        DiffDelete = { fg = "#5A3038", bg = p.git_del_bg },
        DiffText = { bg = p.diff_text_bg, bold = true },
        Added = { fg = p.teal },
        Changed = { fg = p.gold },
        Removed = { fg = p.love },

        -- Spell
        SpellBad = { undercurl = true, sp = p.love },
        SpellCap = { undercurl = true, sp = p.gold },
        SpellLocal = { undercurl = true, sp = p.teal },
        SpellRare = { undercurl = true, sp = p.iris },
    }
end

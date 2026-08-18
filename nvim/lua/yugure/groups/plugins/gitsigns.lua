-- Display-only (git ops live in lazygit). current_line_blame uses eol virt
-- text, so blame must be the dimmest thing on screen.
return function(p)
    -- Dimmed accents: blend(accent, base, 0.6) precomputed as literals.
    local teal_dim = "#607C7F" -- blend(teal, base, 0.6)
    local gold_dim = "#927956" -- blend(gold, base, 0.6)
    local love_dim = "#904B53" -- blend(love, base, 0.6)
    local faint_dim = "#363C4A" -- blend(faint, base, 0.6)

    return {
        GitSignsAdd = { fg = p.teal },
        GitSignsChange = { fg = p.gold },
        GitSignsDelete = { fg = p.love },
        GitSignsTopdelete = { fg = p.love },
        GitSignsChangedelete = { fg = p.gold },
        GitSignsUntracked = { fg = p.faint },

        GitSignsAddNr = { fg = teal_dim },
        GitSignsChangeNr = { fg = gold_dim },
        GitSignsDeleteNr = { fg = love_dim },
        GitSignsTopdeleteNr = { fg = love_dim },
        GitSignsChangedeleteNr = { fg = gold_dim },
        GitSignsUntrackedNr = { fg = faint_dim },

        GitSignsAddLn = { bg = p.git_add_bg },
        GitSignsChangeLn = { bg = p.git_change_bg },
        GitSignsDeleteLn = { bg = p.git_del_bg },

        GitSignsCurrentLineBlame = { fg = p.faint, italic = true },

        GitSignsAddPreview = { fg = p.teal, bg = p.git_add_bg },
        GitSignsDeletePreview = { fg = p.love, bg = p.git_del_bg },
        GitSignsAddInline = { bg = "#24413C" },
        GitSignsChangeInline = { bg = "#2E3B52" },
        GitSignsDeleteInline = { bg = "#4A2A31" },
        GitSignsDeleteVirtLn = { fg = p.love, bg = p.git_del_bg },

        -- Staged signs: same hues as unstaged, dimmed like the Nr groups.
        GitSignsStagedAdd = { fg = teal_dim },
        GitSignsStagedChange = { fg = gold_dim },
        GitSignsStagedDelete = { fg = love_dim },
        GitSignsStagedTopdelete = { fg = love_dim },
        GitSignsStagedChangedelete = { fg = gold_dim },
    }
end

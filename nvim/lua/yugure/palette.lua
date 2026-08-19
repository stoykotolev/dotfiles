-- Yūgure palette. Literal values only — no runtime computation.
return {
    -- Backgrounds
    base = "#191C24",
    low = "#20242F",
    surface = "#1E212B",
    overlay = "#242833",
    med = "#2E3548",
    high = "#3A4152",

    -- Foregrounds (dimmed 2026-08-19: original set was too bright for
    -- long sessions; targets now ~5.5-8.8 vs base instead of 6.8-11.0)
    text = "#B2BACC", -- prev: #C8D0E0
    iron = "#A2ABBE", -- prev: #B3BDD1
    subtle = "#8F99AF", -- prev: #9AA5BC
    muted = "#666F87", -- prev: #6E7791
    faint = "#4A5164",

    -- Accents (exactly 6 hues)
    rose = "#C98995", -- keywords; prev: #D9909B
    gold = "#CFA875", -- string-literals, warnings; prev: #E3B778
    foam = "#7FAEC4", -- callables, info; prev: #8EC2D8
    teal = "#82ABAA", -- types, additions, hints; prev: #8FBCBB
    iris = "#A492C9", -- meta & non-text literals; prev: #B4A0DC
    love = "#C96A70", -- errors only, never syntax; prev: #DF6A72

    -- Derived tints
    git_add_bg = "#1C2A2B",
    git_change_bg = "#1E2533",
    git_del_bg = "#2A1D22",
    diff_text_bg = "#2E3B52",
    search_bg = "#2F4256",
    err_bg = "#2A1E24",
}

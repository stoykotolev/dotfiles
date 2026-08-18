-- Yūgure palette. Literal values only — no runtime computation.
return {
    -- Backgrounds
    base = "#191C24",
    low = "#20242F",
    surface = "#1E212B",
    overlay = "#242833",
    med = "#2E3548",
    high = "#3A4152",

    -- Foregrounds
    text = "#C8D0E0",
    iron = "#B3BDD1",
    subtle = "#9AA5BC",
    muted = "#6E7791",
    faint = "#4A5164",

    -- Accents (exactly 6 hues)
    rose = "#D9909B", -- keywords
    gold = "#E3B778", -- string-literals, warnings
    foam = "#8EC2D8", -- callables, info
    teal = "#8FBCBB", -- types, additions, hints
    iris = "#B4A0DC", -- meta & non-text literals
    love = "#DF6A72", -- errors only, never syntax

    -- Derived tints
    git_add_bg = "#1C2A2B",
    git_change_bg = "#1E2533",
    git_del_bg = "#2A1D22",
    diff_text_bg = "#2E3B52",
    search_bg = "#2F4256",
    err_bg = "#2A1E24",
}

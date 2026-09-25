-- Yūgure (夕暮れ) palette. Literal values only — no runtime computation.
--
-- Layers, dark to light:
--   base    editor background            surface  floats, popups, inactive statusline
--   low     cursorline, scrollbar track  overlay  active statusline, terminal black
--   med     visual, pmenu selection      high     borders, matchparen bg, faint fills
--
-- Foreground tiers (contrast vs base, after the 2026-08-19 dim):
--   text ~8.8 body   iron ~7.4 secondary   subtle ~6.1 UI text
--   muted ~3.9 comments/hints   faint ~2.2 line numbers, whitespace
--
-- Exactly six accent hues, each with one job:
--   rose  keywords, tags, bullets      gold  strings, warnings, cursor line nr
--   foam  functions, links, info       teal  types, additions, hints, success
--   iris  meta, attributes, literals   love  errors and deletions only, never syntax
--
-- Keep it that way: a new colour is a new role, not a new shade.
return {
    -- Backgrounds (darkened 2026-09-25: whole ladder pulled down ~5/ch on
    -- the low layers, ~3/ch on med/high and tints, after the alacritty
    -- switch showed base reading lighter than the old terminal bg)
    base = "#14171F", -- prev: #191C24
    low = "#1B1F2A", -- prev: #20242F
    surface = "#191C26", -- prev: #1E212B
    overlay = "#1F232E", -- prev: #242833
    med = "#2B3245", -- prev: #2E3548
    high = "#373E4F", -- prev: #3A4152

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
    git_add_bg = "#192728", -- prev: #1C2A2B
    git_change_bg = "#1B2230", -- prev: #1E2533
    git_del_bg = "#271A1F", -- prev: #2A1D22
    diff_text_bg = "#2B384F", -- prev: #2E3B52
    search_bg = "#2C3F53", -- prev: #2F4256
    err_bg = "#271B21", -- prev: #2A1E24
}

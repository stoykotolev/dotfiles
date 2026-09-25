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
    -- Backgrounds (2026-09-25: blue-grey ground replaced by a neutral
    -- near-black ladder; the cool tint was reading as a white cast on the
    -- text. Earlier the same day the blue ladder had been darkened ~5/ch.)
    base = "#141518", -- prev: #0E0F12, #14171F
    low = "#1B1C21", -- prev: #16171C, #1B1F2A
    surface = "#18191D", -- prev: #131418, #191C26
    overlay = "#1F2026", -- prev: #1A1B21, #1F232E
    med = "#2A2C34", -- prev: #26282F, #2B3245
    high = "#383A43", -- prev: #34363E, #373E4F

    -- Foregrounds (muted again 2026-09-25 together with a greyer ground:
    -- text ~7, iron ~6, subtle ~5 vs base; first dimmed 2026-08-19 from
    -- the 6.8-11.0 originals)
    text = "#9DA4B2", -- prev: #A8B0C0, #B2BACC, #C8D0E0
    iron = "#8F97A6", -- prev: #A2ABBE, #B3BDD1
    subtle = "#7F8797", -- prev: #8F99AF, #9AA5BC
    muted = "#5E6577", -- prev: #666F87, #6E7791
    faint = "#454A58", -- prev: #4A5164

    -- Accents (exactly 6 hues; desaturated + dimmed 2026-09-25, ~5-6.5 vs base)
    rose = "#B98590", -- keywords; prev: #C98995, #D9909B
    gold = "#BFA077", -- string-literals, warnings; prev: #CFA875, #E3B778
    foam = "#7AA3B5", -- callables, info; prev: #7FAEC4, #8EC2D8
    teal = "#7BA09F", -- types, additions, hints; prev: #82ABAA, #8FBCBB
    iris = "#9A8EB9", -- meta & non-text literals; prev: #A492C9, #B4A0DC
    love = "#BA6B70", -- errors only, never syntax; prev: #C96A70, #DF6A72

    -- Derived tints
    git_add_bg = "#182421", -- prev: #14201F, #192728
    git_change_bg = "#1B1F28", -- prev: #171B24, #1B2230
    git_del_bg = "#261B1E", -- prev: #22161A, #271A1F
    diff_text_bg = "#2B343F", -- prev: #273240, #2B384F
    search_bg = "#2C3745", -- prev: #283645, #2C3F53
    err_bg = "#271C1F", -- prev: #23181C, #271B21
}

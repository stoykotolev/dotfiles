local M = {}

function M.apply(p)
    vim.g.terminal_color_0 = p.overlay
    vim.g.terminal_color_1 = p.love
    vim.g.terminal_color_2 = p.teal
    vim.g.terminal_color_3 = p.gold
    vim.g.terminal_color_4 = p.foam
    vim.g.terminal_color_5 = p.iris
    vim.g.terminal_color_6 = p.rose
    vim.g.terminal_color_7 = p.text
    vim.g.terminal_color_8 = p.muted
    -- Bright variants: lighten(accent, 0.12); 15 = text (matches alacritty).
    vim.g.terminal_color_9 = "#C27D81"
    vim.g.terminal_color_10 = "#8BABAB"
    vim.g.terminal_color_11 = "#C7AB87"
    vim.g.terminal_color_12 = "#8AAEBE"
    vim.g.terminal_color_13 = "#A69CC1"
    vim.g.terminal_color_14 = "#C1949D"
    vim.g.terminal_color_15 = p.text
end

return M

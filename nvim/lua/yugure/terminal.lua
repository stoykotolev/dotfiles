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
    -- Bright variants: lighten(accent, 0.12); 15 = lighten(text, 0.48).
    vim.g.terminal_color_9 = "#CF7C81"
    vim.g.terminal_color_10 = "#91B5B4"
    vim.g.terminal_color_11 = "#D5B286"
    vim.g.terminal_color_12 = "#8EB8CB"
    vim.g.terminal_color_13 = "#AF9FCF"
    vim.g.terminal_color_14 = "#CF97A2"
    vim.g.terminal_color_15 = "#D7DBE4"
end

return M

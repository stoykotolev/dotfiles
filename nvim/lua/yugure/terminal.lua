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
    -- Bright variants: hand-tuned lightened accents.
    vim.g.terminal_color_9 = "#EA8189"
    vim.g.terminal_color_10 = "#A3CCCB"
    vim.g.terminal_color_11 = "#EFCB94"
    vim.g.terminal_color_12 = "#A6D2E4"
    vim.g.terminal_color_13 = "#C6B6E8"
    vim.g.terminal_color_14 = "#E7ABB4"
    vim.g.terminal_color_15 = "#E2E8F2"
end

return M

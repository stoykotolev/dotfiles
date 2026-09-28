local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })

---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
    return "%2l:%-2v"
end

require("todo-comments").setup({ signs = false })

-- LSP progress in the corner — shows when servers are done loading a file
require("fidget").setup({
    notification = {
        window = {
            winblend = 0,
        },
    },
})

-- In-buffer markdown rendering, quiet
require("render-markdown").setup({
    latex = { enabled = false },
})

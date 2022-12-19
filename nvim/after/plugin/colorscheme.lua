-- tokyonight configuration --
-- local present, t = pcall(require, 'tokyonight')
-- if not present then return end
--
-- t.setup({
--   style = "night",
--   transparent = true,
--   terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
--   styles = {
--     keywords = { italic = true },
--     -- Background styles. Can be "dark", "transparent" or "normal"
--     sidebars = "transparent", -- style for sidebars, see below
--     floats = "transparent", -- style for floating windows
--   },
-- })
-- ---------------------------

-- Mellow theme configuration --
-- vim.g.mellow_italic_functions = true
-- vim.g.mellow_bold_functions = true
--------------------------------


function Colors(color)
	color = color or 'rose-pine'
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, 'NormalFloat', { bg = "none" })
	vim.api.nvim_set_hl(0, 'Normal', { bg = "none" })
end

Colors()

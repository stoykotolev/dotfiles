local add, later = MiniDeps.add, MiniDeps.later
local now_if_args = _G.Config.now_if_args

MiniDeps.now(function()
	add('AlexvZyl/nordic.nvim')
	vim.cmd.colorscheme('nordic')
end)

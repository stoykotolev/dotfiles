local add, later = MiniDeps.add, MiniDeps.later
local now_if_args = _G.Config.now_if_args

MiniDeps.now(function()
	add('AlexvZyl/nordic.nvim')
	vim.cmd.colorscheme('nordic')
end)

add({
	source = 'stevearc/oil.nvim',
	depends = {'nvim-tree/nvim-web-devicons'},
})

later(function() 
	require("oil").setup({
                columns = { "icon" },
                keymaps = {
                    ["<C-h>"] = false,
                    ["<M-h>"] = "actions.select_split",
                },
                view_options = {
                    show_hidden = true,
                },
	})
end)

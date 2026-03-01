local now, add, later = MiniDeps.now, MiniDeps.add, MiniDeps.later
local now_if_args = _G.Config.now_if_args

now(function()
  add('AlexvZyl/nordic.nvim')
  vim.cmd.colorscheme('nordic')
end)

later(function()
  add({
    source = 'stevearc/oil.nvim',
    depends = { 'nvim-tree/nvim-web-devicons' },
  })
  require('oil').setup({
    columns = { 'icon' },
    keymaps = {
      ['<C-h>'] = false,
      ['<M-h>'] = 'actions.select_split',
    },
    view_options = {
      show_hidden = true,
    },
  })
end)


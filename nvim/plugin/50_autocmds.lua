_G.Config.new_autocmd(
  'TextYankPost',
  nil,
  function() vim.hl.on_yank() end,
  'Highlight when yanking (copying) text'
)

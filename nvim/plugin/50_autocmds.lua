_G.Config.new_autocmd(
  'TextYankPost',
  nil,
  function() vim.hl.on_yank() end,
  'Highlight when yanking (copying) text'
)
-- Autocommands ===============================================================
-- Do on `FileType` to always override these changes from filetype plugins.
local ensure_fo = function() vim.cmd('setlocal formatoptions-=c formatoptions-=o') end
_G.Config.new_autocmd('FileType', '*', ensure_fo, "Proper 'formatoptions'")

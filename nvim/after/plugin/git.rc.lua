local present, git = pcall(require, 'git')
if not present then return end

git.setup({
  keymaps = {
    blame = '<Leader>gb',
    browse = '<Leader>go'
  }
})

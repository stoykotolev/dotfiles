local present, prettier = pcall(require, 'prettier')
if not present then return end

prettier.setup {
  bin = 'prettier',
  filetype = {
    'css',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'json',
    'scss',
  }
}

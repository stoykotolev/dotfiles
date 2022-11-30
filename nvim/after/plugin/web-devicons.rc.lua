local present, icons = pcall(require, 'nvim-web-devicons')
if not present then return end


icons.setup {
  override = {},
  default = true
}

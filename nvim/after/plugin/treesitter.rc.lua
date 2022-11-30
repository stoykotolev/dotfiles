local present, tsitter = pcall(require, 'nvim-treesitter.configs')
if not present then return end

tsitter.setup {
  highlight = {
    enable = true,
    disable = {}
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    'tsx',
    'lua',
    'json',
    'css',
    'prisma',
    'elixir',
    'typescript',
    'html',
    'javascript',
    'yaml',
    "rust"
  },
  autotag = {
    enable = true
  }
}

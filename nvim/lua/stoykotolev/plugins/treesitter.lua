return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    config = function(_, opts)
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          -- defaults
          'vim',
          'lua',
          'markdown',
          -- web dev
          'html',
          'css',
          'javascript',
          'typescript',
          'tsx',
          'graphql',

          -- General programing
          'rust',
          'go',
          'json',
          'yaml',
          'bash',

          -- devops stuff
          'dockerfile',
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup()
    end,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    event = 'VeryLazy',
    commit = '92e688f013c69f90c9bbd596019ec10235bc51de',
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    commit = '6be1192965df35f94b8ea6d323354f7dc7a557e4',
  },
}

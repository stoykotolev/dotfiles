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

--- TreeSitter and TS adjacent things
-- Treesitter
now_if_args(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    -- Update tree-sitter parser after plugin is updated
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })
  add({
    source = 'nvim-treesitter/nvim-treesitter-textobjects',
    checkout = 'main',
  })

  -- Define languages which will have parsers installed and auto enabled
  local languages = {
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'regex',
    'vim',
    -- General programing
    'vimdoc',
    'dockerfile',
    'bash',
    'go',
    'gomod',
    'gowork',
    'json',
    'yaml',
    'toml',
    -- Webdev
    'tsx',
    'typescript',
    'jsx',
    'javascript',
    'html',
    'css',
    'graphql',
  }
  local isnt_installed = function(lang)
    return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
  end
  local to_install = vim.tbl_filter(isnt_installed, languages)
  if #to_install > 0 then require('nvim-treesitter').install(to_install) end

  -- Enable tree-sitter after opening a file for a target language
  local filetypes = vim
    .iter(languages)
    :map(vim.treesitter.language.get_filetypes)
    :flatten()
    :totable()
  local ts_start = function(ev) vim.treesitter.start(ev.buf) end
  _G.Config.new_autocmd(
    'FileType',
    filetypes,
    ts_start,
    'Ensure enabled tree-sitter'
  )
end)

-- TS Adjacent
later(function()
  add({
    source = 'windwp/nvim-ts-autotag',
  })
  require('nvim-ts-autotag').setup()

  add({
    source = 'axelvc/template-string.nvim',
  })
  require('template-string').setup({
    filetypes = {
      'html',
      'typescript',
      'javascript',
      'typescriptreact',
      'javascriptreact',
    },
    jsx_brackets = true,
  })
  add({
    source = 'nvim-treesitter/nvim-treesitter-context',
  })
  require('treesitter-context').setup({
    max_lines = 1,
  })
end)

--- End of TS Stuff

-- LSP and LSP adjacent things
-- Mason
now(function()
  add('mason-org/mason.nvim')
  add('WhoIsSethDaniel/mason-tool-installer.nvim')
  require('mason').setup()
  require('mason-tool-installer').setup({
    ensure_installed = {
      -- LSPs
      'lua-language-server',
      'tailwindcss-language-server',
      'emmet-language-server',
      'html-lsp',
      'css-lsp',
      'graphql-language-service-cli',
      -- Linters
      'eslint_d',
      'stylua',
      -- Formatters
      'prettierd',
    },
  })
end)

-- Formatting
later(function()
  add('stevearc/conform.nvim')
  add('mfussenegger/nvim-lint')
  require('conform').setup({
    default_format_opts = {
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      html = { 'prettierd' },
      css = { 'prettierd' },
    },
    format_on_save = function(bufnr)
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match('/node_modules/') then return end
      return {
        timeout_ms = 500,
      }
    end,
  })

  require('lint').linters_by_ft = {
    javascript = { 'eslint_d' },
    typescript = { 'eslint_d' },
    javascriptreact = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
  }

  _G.Config.new_autocmd(
    'BufWritePost',
    '*',
    function() require('lint').try_lint() end
  )
end)

-- LSP Config enable
now_if_args(function()
  add('neovim/nvim-lspconfig')
  vim.lsp.enable({
    'lua_ls',
    'tailwindcss-language-server',
    'emmet_language_server',
    'html',
    'cssls',
    'graphql',
  })
end)

-- Snippets
later(function() add('rafamadriz/friendly-snippets') end)

later(function()
  add({
    source = 'lewis6991/gitsigns.nvim',
  })
  require('gitsigns').setup({
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '│' },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  })
end)

later(function()
  add({
    source = 'folke/noice.nvim',
    depends = { 'MunifTanjim/nui.nvim' },
  })
  require('noice').setup({
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
      progress = {
        enabled = false,
      },
      signature = {
        enabled = false,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    messages = {
      enabled = false, -- enables the Noice messages UI
      view = 'notify', -- default view for messages
      view_error = 'notify', -- view for errors
      view_warn = 'notify', -- view for warnings
      view_history = 'messages', -- view for :messages
      view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
    },
  })
end)

later(function()
  add({
    source = 'pmizio/typescript-tools.nvim',
    depends = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
  })
  local api = require('typescript-tools.api')
  require('typescript-tools').setup({
    handlers = {
      ['textDocument/publishDiagnostics'] = api.filter_diagnostics({ 6133 }),
    },
    settings = {
      tsserver_file_preferences = {
        importModuleSpecifierPreference = 'non-relative',
      },
    },
  })
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.ts,*.tsx,*.jsx,*.js',
    callback = function() vim.cmd('TSToolsAddMissingImports sync') end,
  })
end)

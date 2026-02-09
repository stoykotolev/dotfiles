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
later(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    -- Use 'master' while monitoring updates in 'main'
    checkout = 'master',
    monitor = 'main',
    -- Perform action after every checkout
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
    depends = {
      'windwp/nvim-ts-autotag',
      'axelvc/template-string.nvim',
    },
  })
  require('nvim-treesitter.configs').setup({
  --stylua: ignore
    ensure_installed = {
    'lua', 'luadoc', 'markdown', 'markdown_inline', 'regex', 'vim',
    -- General programing
    'vimdoc', 'dockerfile', 'bash', 'go', 'gomod', 'gowork', 'json', 'yaml', 'toml',
    -- Webdev
    'typescript', 'javascript', 'html', 'css', 'graphql',
  },
    auto_install = true,
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<enter>',
        node_incremental = '<enter>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
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
  require('nvim-ts-autotag').setup()
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
      'gopls',
      -- Linters
      'eslint_d',
      'stylua',
      'golangci-lint',
      -- Formatters
      'prettierd',
      'gofumpt',
      'golines',
      'goimports-reviser',
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
    'gopls',
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

-- later(function()
--   add({
--     source = 'folke/noice.nvim',
--     depends = { 'MunifTanjim/nui.nvim' },
--   })
--   require('noice').setup({
--     lsp = {
--       -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
--       override = {
--         ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
--         ['vim.lsp.util.stylize_markdown'] = true,
--         ['cmp.entry.get_documentation'] = true,
--       },
--       progress = {
--         enabled = false,
--       },
--       signature = {
--         enabled = false,
--       },
--     },
--     -- you can enable a preset for easier configuration
--     presets = {
--       bottom_search = true, -- use a classic bottom cmdline for search
--       long_message_to_split = true, -- long messages will be sent to a split
--       inc_rename = false, -- enables an input dialog for inc-rename.nvim
--       lsp_doc_border = false, -- add a border to hover docs and signature help
--     },
--     messages = {
--       enabled = false, -- enables the Noice messages UI
--       view = 'notify', -- default view for messages
--       view_error = 'notify', -- view for errors
--       view_warn = 'notify', -- view for warnings
--       view_history = 'messages', -- view for :messages
--       view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
--     },
--   })
-- end)

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

-- Debugging
later(function()
  add({
    source = 'mfussenegger/nvim-dap',
    depends = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'theHamsta/nvim-dap-virtual-text',
      'leoluz/nvim-dap-go',
    },
  })
  local dapui = require('dapui')

  require('mason-nvim-dap').setup({
    -- Makes a best effort to setup the various debuggers with
    -- reasonable debug configurations
    automatic_setup = true,

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    handlers = {},

    -- You'll need to check that you have the required things installed
    -- online, please don't ask me how to install them :)
    ensure_installed = {
      -- Update this to ensure that you have the debuggers for the langs you want
      'delve',
    },
  })
  dapui.setup({
    icons = {
      expanded = '▾',
      collapsed = '▸',
      current_frame = '*',
    },
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
  })

  local dap = require('dap')
  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close
  require('dap-go').setup()

  local nmap_leader = function(suffix, rhs, desc)
    vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc })
  end
  nmap_leader('dc', dap.continue, '[D]ebug: Start/[C]ontinue')
  nmap_leader('dsi', dap.step_into, '[D]ebug: [S]tep [I]nto')
  nmap_leader('dso', dap.step_over, '[D]ebug: [S]tep [O]ver')
  nmap_leader('dsu', dap.step_out, '[D]ebug: [S]tep O[u]t')
  nmap_leader('b', dap.toggle_breakpoint, 'Debug: Toggle [B]reakpoint')
  nmap_leader(
    'B',
    function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    'Debug: Set Breakpoint'
  )

  nmap_leader('du', require('dapui').toggle, 'Debug: See last session result.')
end)

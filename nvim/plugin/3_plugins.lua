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
      graphql = { 'prettierd' },
      json = { 'prettierd' },
    },
    format_on_save = function(bufnr)
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match('/node_modules/') then return end
      return {
        timeout_ms = 500,
        lsp_format = 'fallback',
      }
    end,
  })

  local ft_linters = {
    javascript = { 'eslint_d' },
    typescript = { 'eslint_d' },
    javascriptreact = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
  }
  local linter_root_markers = {
    biomejs = { 'biome.json', 'biome.jsonc' },
    eslint_d = {
      'eslint.config.js',
      'eslint.config.mjs',
      'eslint.config.cjs',
      'eslint.config.ts',
      'eslint.config.mts',
      'eslint.config.cts',
      -- deprecated
      '.eslintrc.js',
      '.eslintrc.cjs',
      '.eslintrc.yaml',
      '.eslintrc.yml',
      '.eslintrc.json',
    },
  }
  require('lint').linters_by_ft = ft_linters

  _G.Config.new_autocmd(
    { 'BufEnter', 'BufWritePost', 'InsertLeave' },
    '*',
    function()
      local lint = require('lint')
      if vim.opt_local.modifiable:get() then
        local names = ft_linters[vim.bo.filetype]

        if names == nil then return end

        for _, name in pairs(names) do
          local next = next
          if
            linter_root_markers[name] == nil
            or next(vim.fs.find(linter_root_markers[name], { upward = true }))
          then
            lint.try_lint(name)
          end
        end
      end
    end
  )
end)

-- LSP Config enable
now_if_args(function()
  add('neovim/nvim-lspconfig')
  vim.lsp.enable({
    'lua_ls',
    'tailwindcss',
    'emmet_language_server',
    'html',
    'cssls',
    'graphql',
    'gopls',
  })
end)

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

  _G.Maps.leader('dc', dap.continue, '[D]ebug: Start/[C]ontinue')
  _G.Maps.leader('dsi', dap.step_into, '[D]ebug: [S]tep [I]nto')
  _G.Maps.leader('dso', dap.step_over, '[D]ebug: [S]tep [O]ver')
  _G.Maps.leader('dsu', dap.step_out, '[D]ebug: [S]tep O[u]t')
  _G.Maps.leader('b', dap.toggle_breakpoint, 'Debug: Toggle [B]reakpoint')
  _G.Maps.leader(
    'B',
    function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    'Debug: Set Breakpoint'
  )

  _G.Maps.leader('du', require('dapui').toggle, 'Debug: See last session result.')
end)

-- Mini stuff
now(function()
  local statusline = require('mini.statusline')
  statusline.setup()

  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function() return '%2l:%-2v' end
end)
-- Snippets
later(function()
  -- Define language patterns to work better with 'friendly-snippets'
  local lang_patterns = {
    markdown_inline = { 'markdown.json' },
  }

  local snippets = require('mini.snippets')
  local config_path = vim.fn.stdpath('config')
  snippets.setup({
    snippets = {
      snippets.gen_loader.from_file(config_path .. '/snippets/global.json'),
      snippets.gen_loader.from_lang({ lang_patterns = lang_patterns }),
    },
  })
  MiniSnippets.start_lsp_server()
end)

later(function()
  -- Create pairs not only in Insert, but also in Command line mode
  require('mini.pairs').setup({ modes = { command = true } })
end)

-- Completion
later(function()
  add({
    source = 'saghen/blink.cmp',
    depends = { 'rafamadriz/friendly-snippets' },
    hooks = { post_checkout = function() vim.fn.system('cargo build --release') end },
  })
  require('blink.cmp').setup({
    keymap = {
      preset = 'default',
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'show', 'fallback' },
      ['<C-l>'] = { 'snippet_forward', 'fallback' },
      ['<C-h>'] = { 'snippet_backward', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono',
      use_nvim_cmp_as_default = true,
    },
    completion = {
      trigger = {
        show_on_insert_on_trigger_character = false,
      },
      documentation = {
        auto_show = true,
      },
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
      menu = {
        draw = {
          columns = {
            { 'label', 'label_description', gap = 1 },
            { 'kind_icon', 'kind' },
          },
        },
      },
    },
    signature = { enabled = true },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  })
end)

-- Telescope
later(function()
  add({
    source = 'nvim-telescope/telescope-fzf-native.nvim',
    hooks = { post_checkout = function() vim.fn.system('make') end },
  })
  add({
    source = 'nvim-telescope/telescope.nvim',
    depends = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  })
  require('telescope').setup({
    defaults = {
      mappings = {
        i = {
          ['<C-n>'] = require('telescope.actions').select_tab,
          ['<C-d>'] = require('telescope.actions').delete_buffer,
          ['<C-k>'] = require('telescope.actions').move_selection_previous,
          ['<C-j>'] = require('telescope.actions').move_selection_next,
          ['<C-q>'] = require('telescope.actions').send_selected_to_qflist
            + require('telescope.actions').open_qflist,
        },
        n = {
          ['q'] = require('telescope.actions').close,
          ['dd'] = require('telescope.actions').delete_buffer,
          ['x'] = require('telescope.actions').delete_buffer,
        },
      },
      sorting_strategy = 'ascending',
      layout_strategy = 'horizontal',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = { mirror = false },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      border = {},
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      color_devicons = true,
      use_less = true,
      set_env = { ['COLORTERM'] = 'truecolor' },
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
  })

  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')

  local builtin = require('telescope.builtin')
  _G.Maps.leader('sh', builtin.help_tags, '[S]earch [H]elp')
  _G.Maps.leader('sk', builtin.keymaps, '[S]earch [K]eymaps')
  _G.Maps.leader('ff', builtin.find_files, '[F]ind [F]iles')
  _G.Maps.leader('st', builtin.builtin, '[S]earch Select [T]elescope')
  _G.Maps.leader('fcw', builtin.grep_string, '[F]ind [C]urrent [W]ord')
  _G.Maps.leader('fw', builtin.live_grep, '[F]ind by [W]ord')
  _G.Maps.leader('sd', builtin.diagnostics, '[S]earch [D]iagnostics')
  _G.Maps.leader('sr', builtin.resume, '[S]earch [R]esume')
  _G.Maps.leader('s.', builtin.oldfiles, '[S]earch Recent Files ("." for repeat)')
  _G.Maps.leader('<leader>', builtin.buffers, '[ ] Find existing buffers')
  _G.Maps.leader(
    's/',
    function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      })
    end,
    '[S]earch [/] in Open Files'
  )
  _G.Maps.leader(
    'sn',
    function() builtin.find_files({ cwd = vim.fn.stdpath('config') }) end,
    '[S]earch [N]eovim files'
  )
end)

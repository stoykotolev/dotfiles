local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api
        .nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match '%s'
      == nil
end

return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '│' },
          change = { text = '│' },
          delete = { text = '󰍵' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
          untracked = { text = '│' },
        },
        current_line_blame = true,
      }
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer', -- source for text in buffer
      'hrsh7th/cmp-path', -- source for file system paths
      'L3MON4D3/LuaSnip', -- snippet engine
      'saadparwaiz1/cmp_luasnip', -- for autocompletion
      'rafamadriz/friendly-snippets', -- useful snippets
    },
    config = function()
      local cmp = require 'cmp'

      local luasnip = require 'luasnip'

      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup {
        completion = {
          completeopt = 'menu,menuone,preview,noselect',
        },
        window = {
          completion = cmp.config.window.bordered {},
          documentation = cmp.config.window.bordered {},
          scrollbar = false,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
          ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
          ['<C-e>'] = cmp.mapping.abort(), -- close completion window
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              -- they way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'buffer' }, -- text within current buffer
          { name = 'luasnip' }, -- snippets
          { name = 'path' }, -- file system paths
        },
      }
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local npairs = require 'nvim-autopairs'
      local Rule = require 'nvim-autopairs.rule'

      npairs.setup {
        check_ts = true,
        ts_config = {
          lua = { 'string' },
          japascript = { 'template_string' },
        },
        enable_check_bracket_line = false,
      }

      local ts_conds = require 'nvim-autopairs.ts-conds'

      -- press % => %% only while inside a comment or string
      npairs.add_rules {
        Rule('%', '%', 'lua'):with_pair(
          ts_conds.is_ts_node { 'string', 'comment' }
        ),
        Rule('$', '$', 'lua'):with_pair(ts_conds.is_not_ts_node { 'function' }),
      }
    end,
  },
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
      },
      opleader = {
        ---Line-comment keymap
        line = 'gc',
        ---Block-comment keymap
        block = 'gb',
      },
      ---LHS of extra mappings
      extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
      },
      ---Enable keybindings
      ---NOTE: If given `false` then the plugin won't create any mappings
      mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
      },
      ---Function to call before (un)comment
      pre_hook = function(...)
        local loaded, ts_comment =
          pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
        if loaded and ts_comment then
          return ts_comment.create_pre_hook()(...)
        end
      end,
      ---Function to call after (un)comment
      post_hook = nil,
    },
    config = true,
  },
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
      }
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      require('conform').setup {
        formatters_by_ft = {
          lua = { 'stylua' },
          javascript = { 'prettierd' },
          typescript = { 'prettierd' },
          javascriptreact = { 'prettierd' },
          typescriptreact = { 'prettierd' },
          css = { 'prettierd' },
          html = { 'prettierd' },
          json = { 'prettierd' },
          yaml = { 'prettierd' },
          markdown = { 'prettierd' },
          graphql = { 'prettierd' },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      }
    end,
  },
}

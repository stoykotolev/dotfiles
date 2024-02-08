return {
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.o.background = 'dark' -- or "light" for light mode
      vim.cmd "let g:gruvbox_material_background= 'hard'"
      vim.cmd 'let g:gruvbox_material_transparent_background=2'
      vim.cmd 'let g:gruvbox_material_diagnostic_line_highlight=1'
      vim.cmd "let g:gruvbox_material_diagnostic_virtual_text='colored'"
      vim.cmd 'let g:gruvbox_material_enable_bold=1'
      vim.cmd 'let g:gruvbox_material_enable_italic=1'
      vim.cmd [[colorscheme gruvbox-material]] -- Set color scheme
      -- changing bg and border colors
      vim.api.nvim_set_hl(1, 'FloatBorder', { link = 'Normal' })
      vim.api.nvim_set_hl(1, 'LspInfoBorder', { link = 'Normal' })
      vim.api.nvim_set_hl(1, 'NormalFloat', { link = 'Normal' })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'gruvbox-material',
        },
      }
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
  },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<C-e>', '<cmd> NvimTreeToggle <CR>' },
    },

    config = function()
      require('nvim-tree').setup {
        filters = {
          dotfiles = false,
          exclude = { vim.fn.stdpath 'config' .. '/lua/custom' },
        },
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = false,
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        view = {
          adaptive_size = false,
          side = 'left',
          width = 30,
          preserve_window_proportions = true,
        },
        git = {
          enable = false,
          ignore = true,
        },
        filesystem_watchers = {
          enable = true,
        },
        actions = {
          open_file = {
            resize_window = true,
            quit_on_open = true,
          },
        },
        renderer = {
          root_folder_label = false,
          highlight_git = false,
          highlight_opened_files = 'none',

          indent_markers = {
            enable = false,
          },

          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = false,
            },

            glyphs = {
              default = '󰈚',
              symlink = '',
              folder = {
                empty = '',
                empty_open = '',
                open = '',
                symlink = '',
                symlink_open = '',
                arrow_open = '',
                arrow_closed = '',
              },
              git = {
                unstaged = '✗',
                staged = '✓',
                unmerged = '',
                renamed = '➜',
                untracked = '★',
                deleted = '',
                ignored = '◌',
              },
            },
          },
        },
      }
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = '*',
    event = 'VeryLazy',
    keys = {
      { '<Tab>',   '<Cmd>BufferLineCycleNext<CR>', desc = 'Next tab' },
      { '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Prev tab' },
    },
    opts = {
      options = {
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Tree',
            highlight = 'Directory',
            separator = true, -- use a "true" to enable the default, or set your own character
          },
        },
        diagnostics = 'nvim_lsp',
        separator_style = { '', '' },
        modified_icon = '●',
        show_close_icon = false,
        show_buffer_close_icons = false,
      },
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = '50%',
          },
          size = {
            width = 60,
            height = 'auto',
          },
        },
        popupmenu = {
          relative = 'editor',
          position = {
            row = 8,
            col = '50%',
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = 'rounded',
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
          },
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    'rcarriga/nvim-notify',
    opts = {
      timeout = 1000,
      background_colour = '#000000',
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    keys = {
      {
        '<leader>rn',
        function()
          require('notify').dismiss { silent = true, pending = true }
        end,
      },
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
}

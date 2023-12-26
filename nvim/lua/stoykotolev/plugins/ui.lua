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
  -- {
  --   'navarasu/onedark.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  --   config = function()
  --     require('onedark').setup {
  --       style = 'darker',
  --       transparent = true, -- Show/hide background
  --       term_colors = true, -- Change terminal color as per the selected theme style
  --       colors = {
  --         black = '#24292f',
  --         bg0 = '#1f2329',
  --         bg1 = '#282c34',
  --         bg2 = '#30363f',
  --         bg3 = '#323641',
  --         bg_d = '#181b20',
  --         bg_blue = '#4f6286',
  --         bg_yellow = '#e3786c',
  --         fg = '#a0a8b7',
  --         purple = '#a97594',
  --         green = '#618774',
  --         orange = '#cc9057',
  --         blue = '#5c6b92',
  --         yellow = '#e2b86b',
  --         cyan = '#6ba5ab',
  --         red = '#dc6f7a',
  --         grey = '#535965',
  --         light_grey = '#7a818e',
  --         dark_cyan = '#4f8896',
  --         dark_red = '#8b3434',
  --         dark_yellow = '#835d1a',
  --         dark_purple = '#b589a4',
  --         diff_add = '#272e23',
  --         diff_delete = '#2d2223',
  --         diff_change = '#172a3a',
  --         diff_text = '#274964',
  --         diagnostics = {
  --           darker = true, -- darker colors for diagnostic
  --           undercurl = true, -- use undercurl instead of underline for diagnostics
  --           background = true, -- use background color for virtual text
  --         },
  --       },
  --     }
  --     require('onedark').load()
  --   end,
  -- },
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
      { '<Tab>', '<Cmd>BufferLineCycleNext<CR>', desc = 'Next tab' },
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

local plugins = {
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require "custom.configs.cmp"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        use_language = true,
        disable = {},
      },
      matchup = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = {},
      },
      autotag = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      ensure_installed = {
        -- defaults
        "vim",
        "lua",
        "markdown",

        -- web dev
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "graphql",
        "yaml",
        "prisma",

        -- devops stuff
        "dockerfile",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require "custom.configs.lspsaga"
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "tailwindcss-language-server",
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "marksman",
        "prettierd",
        "eslint_d",
        "stylua",
        "rust-analyzer",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.configs.null-ls"
      end,
    },

    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
}

return plugins

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })

    print("Installing packer...")

    vim.cmd([[packadd packer.nvim]])

    return true
  end

  return false
end

local packer_bootstrap = ensure_packer()

-- reload neovim whenever plugins.lua is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])


return require("packer").startup({
  function(use)
    use 'wbthomason/packer.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'hoob3rt/lualine.nvim'
    -- use { 'folke/tokyonight.nvim', requires = { 'tjdevries/colorbuddy.nvim' } }
    -- use {
    --   'svrana/neosolarized.nvim',
    --   requires = { 'tjdevries/colorbuddy.nvim' }
    -- }
    -- use({
    --   'rose-pine/neovim',
    --   as = 'rose-pine',
    --   config = function()
    --     vim.cmd('colorscheme rose-pine')
    --   end
    -- })
    use 'kvrohit/mellow.nvim'
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }
    use 'windwp/nvim-ts-autotag'
    use 'windwp/nvim-autopairs'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'akinsho/bufferline.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use 'glepnir/lspsaga.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'MunifTanjim/prettier.nvim'
    use 'lewis6991/gitsigns.nvim'
    use 'dinhhuy258/git.nvim'

    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    use { 'hrsh7th/vim-vsnip' }
    use { 'hrsh7th/cmp-vsnip' }

    use 'numToStr/Comment.nvim'
    use 'ThePrimeagen/vim-be-good'

    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
})

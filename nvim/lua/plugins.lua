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

		-- colorschemes --
		-- use { 'folke/tokyonight.nvim', requires = { 'tjdevries/colorbuddy.nvim' } }
		-- use {
		--   'svrana/neosolarized.nvim',
		--   requires = { 'tjdevries/colorbuddy.nvim' }
		-- }
		use 'kvrohit/mellow.nvim'

		-- icons
		use 'kyazdani42/nvim-web-devicons'

		-- statusline
		use 'hoob3rt/lualine.nvim'

		-- lsp block --
		use 'neovim/nvim-lspconfig' -- lsp
		use 'onsails/lspkind-nvim' --

		use 'williamboman/mason.nvim' -- lsp installer
		use 'williamboman/mason-lspconfig.nvim' -- implement with lspconfig
		---------------

		-- autocompletion
		use 'hrsh7th/nvim-cmp'
		use 'hrsh7th/cmp-buffer'
		use 'hrsh7th/cmp-nvim-lsp'
		use "hrsh7th/cmp-nvim-lua"
		use 'hrsh7th/vim-vsnip'
		use 'hrsh7th/cmp-vsnip'

		-- snippets
		use 'L3MON4D3/LuaSnip'

		-- Treesitter
		use {
			'nvim-treesitter/nvim-treesitter',
			run = ':TSUpdate'
		}

		use 'windwp/nvim-ts-autotag' -- close and rename html tabs
		use 'windwp/nvim-autopairs' -- autoclose bracket pair

		-- Telescope block --
		use { 'nvim-telescope/telescope.nvim', tag = "0.1.0", requires = { 'nvim-lua/plenary.nvim' } }
		use 'nvim-telescope/telescope-file-browser.nvim'
		---------------------

		use 'akinsho/bufferline.nvim' -- bufferline with icons, etc.

		use 'glepnir/lspsaga.nvim'

		use 'jose-elias-alvarez/null-ls.nvim' -- formatting, code actions and diagnostics

		-- Git block --
		use 'lewis6991/gitsigns.nvim'
		use 'dinhhuy258/git.nvim'
		---------------

		use 'numToStr/Comment.nvim' -- add comments with keymap
		use 'ThePrimeagen/vim-be-good' -- git gut in vim

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

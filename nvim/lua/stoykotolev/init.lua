-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local set = vim.opt
-- Options
vim.g.have_nerd_font = true
vim.o.termguicolors = true

-- Make line numbers default and show relative numbers
set.number = true
set.relativenumber = true
set.showmode = false          -- mode is already in status line
set.clipboard = 'unnamedplus' -- sync clipboard cuz yeah
set.breakindent = true        -- keep indent when linebreak
set.undofile = true           -- undo history

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
set.ignorecase = true
set.smartcase = true
set.signcolumn = 'yes' -- sign column cuz we have them

set.updatetime = 250   -- Decrease update time
set.timeoutlen = 300   -- Decrease mapped sequence wait time

set.splitright = true  -- horizontal split to the right
set.splitbelow = true  -- vert split on the bottom

-- Sets how neovim will display certain whitespace characters in the editor.
set.list = true
set.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

set.inccommand = 'split' -- preview text replace live
set.cursorline = true    -- indicate where the cursor is
set.scrolloff = 10       -- at least 10 lines above and below curr line
set.hlsearch = true      -- highlight on search

set.formatoptions:remove "o" -- making new line with "o" will not add the comment line syntax

-- Keymaps
local map = vim.keymap.set
local opts = { silent = true }

-- Standard remaps --
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<C-a>', 'gg<S-v>G')
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)
map('n', 'n', 'nzz', opts)
map('n', 'N', 'Nzz', opts)
map('n', 'yw', 'yiw', opts)
map('n', 'x', '"_x', opts)
map('n', '<leader>q', '<cmd>q<cr>')
map('n', '<leader>w', '<cmd>w<cr>')
map('n', '<leader>x', '<cmd>x<cr>')
map('n', 'Y', 'yVaB') -- yank whole block

-- Navigation
map('i', '<C-h>', '<Left>')
map('i', '<C-k>', '<Up>')
map('i', '<C-j>', '<Down>')
map('i', '<C-l>', '<Right>')
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Splitting
map('n', '<leader>sv', '<C-w>v')
map('n', '<leader>ss', '<C-w>s')

-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
{
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('nordic').load()
        end
    },
{
  'nvim-treesitter/nvim-treesitter',
    lazy = false,
    event = "BufRead",
    branch = "main",
    build = ":TSUpdate",
    opts = {
	install_dir = vim.fn.stdpath("data") .. "/treesitter",
	ensure_installed = { 'lua', 'vim', 'luadoc'}

    },
  config = function(_,opts)
	if vim.fn.executable("tree-sitter") == 1 then
		vim.defer_fn(function() require("nvim-treesitter").install(opts.ensure_installed) end, 2000)
	else
		local msg = "`tree-sitter-cli` not found. Skipping auto-install of parsers."
		vim.notify(msg, vim.log.levels.WARN, { title = "Treesitter" })
	end

	vim.api.nvim_create_autocmd("FileType", {
		desc = "User: enable treesitter highlighting",
		callback = function(ctx)
			-- highlights
			local hasStarted = pcall(vim.treesitter.start, ctx.buf) -- errors for filetypes with no parser
			-- indent
			local dontUseTreesitterIndent = { "bash", "markdown", "javascript" }
			if hasStarted and not vim.list_contains(dontUseTreesitterIndent, ctx.match) then
				vim.bo[ctx.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
			end
		end,
	})
  end
}
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

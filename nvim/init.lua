-- Leader must be set before any keymaps or plugins are loaded
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.diagnostics")
require("core.pack")

-- Plugin setup. Order matters in a few places:
-- theme first (everything after draws with it), completion before lsp
-- (capabilities), mason before lsp (binaries on PATH).
require("plugins.theme")
require("plugins.treesitter")
require("plugins.editing")
require("plugins.ui")
require("plugins.git")
require("plugins.telescope")
require("plugins.oil")
require("plugins.completion")
require("plugins.mason")
require("plugins.lsp")
require("plugins.formatting")
require("plugins.linting")
require("plugins.testing")
require("plugins.debugging")

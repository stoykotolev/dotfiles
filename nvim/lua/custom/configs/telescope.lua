local present, telescope = pcall(require, "telescope")
if not present then
  return
end

local actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local fb_actions = telescope.extensions.file_browser.actions

local function telescope_buffer_dir()
  return vim.fn.expand "$:p:h"
end

telescope.setup {
  defaults = {
    file_ignore_patterns = { ".git/", "node_modules" },
    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-s>"] = actions.select_horizontal,
      },
      n = {
        ["q"] = actions.close,
      },
    },
  },
  -- pickers = {
  -- 	find_files = {
  -- 		find_command = { "rg", "--type", "f", "--strip-cwd-prefix" },
  -- 	},
  -- },
}

telescope.load_extension "file_browser"

local map = vim.keymap.set

map("n", ";f", function()
  builtin.find_files {
    no_ignore = false,
    hidden = true,
  }
end)

map("n", ";r", function()
  builtin.live_grep()
end)

map("n", "\\\\", function()
  builtin.buffers()
end)

map("n", ";t", function()
  builtin.help_tags()
end)

map("n", ";;", function()
  builtin.resume()
end)

map("n", ";e", function()
  builtin.diagnostics()
end)

map("n", "sf", function()
  telescope.extensions.file_browser.file_browser {
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 },
  }
end)

-- Yūgure (夕暮れ) — twilight colorscheme
-- The background guard avoids the re-source loop `set background` triggers.
if vim.o.background ~= "dark" then
    vim.o.background = "dark"
end
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end
-- Purging the module cache is what makes live reload work.
if vim.g.yugure_dev then
    for name, _ in pairs(package.loaded) do
        if name:match("^yugure") then
            package.loaded[name] = nil
        end
    end
end
vim.g.colors_name = "yugure"
require("yugure").load()

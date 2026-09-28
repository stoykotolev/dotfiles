vim.cmd.colorscheme("yugure")

-- Set `vim.g.yugure_dev = true` above the colorscheme call to get live
-- reload on save plus :YugureContrast and :YugureAudit while tuning.
if vim.g.yugure_dev then
    require("yugure.dev")
end

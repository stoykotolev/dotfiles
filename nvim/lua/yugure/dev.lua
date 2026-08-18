-- Live-reload plumbing while the scheme is being tuned.
local function reload()
    -- pcall so a syntax error mid-edit doesn't leave a cleared UI.
    local ok, err = pcall(vim.cmd.colorscheme, "yugure")
    if not ok then
        vim.notify("yugure reload failed: " .. err, vim.log.levels.ERROR)
    end
end

vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("yugure-dev-reload", { clear = true }),
    -- `*` crosses path separators in autocmd patterns, so subdirs match too.
    pattern = {
        "*/lua/yugure/*.lua",
        "*/colors/yugure.lua",
    },
    callback = reload,
})

vim.api.nvim_create_user_command("YugureReload", reload, {
    desc = "Reload the yugure colorscheme",
})

vim.g.yugure_dev = true -- flip to false / delete when the scheme is settled
vim.cmd.colorscheme("yugure")
if vim.g.yugure_dev then
    require("yugure.dev")
end

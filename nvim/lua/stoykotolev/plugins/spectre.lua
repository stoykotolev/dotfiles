return {
    "nvim-pack/nvim-spectre",
    depends = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        require("spectre").setup({
            default = {
                replace = {
                    cmd = "sed"
                }
            }
        })
    end
}

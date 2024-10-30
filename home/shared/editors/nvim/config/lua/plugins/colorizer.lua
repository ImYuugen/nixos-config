return {
    "colorizer",
    event = "DeferredUIEnter",
    after = function()
        require("colorizer").setup({
            filetypes = { "*" },
            user_default_options = {
                mode = "virtualtext",
                virtualtext = "",
                tailwind = true,
                sass = { enable = true, parsers = { "css" } },
            },
        })
    end,
}

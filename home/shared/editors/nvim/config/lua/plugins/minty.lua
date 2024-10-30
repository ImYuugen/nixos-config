return {
    {
        "vimplugin-volt",
    },
    {
        "vimplugin-minty",
        cmd = { "Shades", "Huefy" },
        after = function()
            require("minty").setup({})
        end,
    }
}

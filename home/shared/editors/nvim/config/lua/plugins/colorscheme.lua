return {
  {
    "rose-pine",
    enabled = true,
    colorscheme = "rose-pine",
    beforeAll = function()
      require("rose-pine").setup({
        variant = "auto",
        dark_variant = "main",
        styles = {
          transparency = false,
        },
      })
    end,
  }
}

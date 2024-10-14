return {
  "cord.nvim",
  event = "DeferredUIEnter",
  after = function()
    require("cord").setup({})
  end
}

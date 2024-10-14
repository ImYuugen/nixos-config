return {
  "conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  after = function()
    local c = require("conform")
    c.setup({
      default_format_opts = { lsp_format = "fallback", },
      formatters_by_ft = {}, -- Configured in langs/<language>.lua
      format_on_save = {
        timeout = 500,
      },
      format_after_save = {
        async = true,
      },
    })
  end
}

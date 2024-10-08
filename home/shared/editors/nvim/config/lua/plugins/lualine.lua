local utils = require("utils")

return {
  "lualine.nvim",
  event = "UIEnter",
  after = function()
    vim.o.laststatus = 2
    require("lualine").setup({
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", }, },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              hint = utils.icons.diagnostics.Hint,
              info = utils.icons.diagnostics.Info,
              warn = utils.icons.diagnostics.Warn,
              error = utils.icons.diagnostics.Error,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = { modified = "*", readonly = "!", unnamed = "無" } },
        },
        lualine_x = {
          {
            "diff",
            symbols = {
              added = utils.icons.git.Added,
              removed = utils.icons.git.Removed,
              modified = utils.icons.git.Modified,
            },
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 }, },
          { "location", padding = { left = 0, right = 1 }, },
        },
        lualine_z = {},
      },
    })
  end
}

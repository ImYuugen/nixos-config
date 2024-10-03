local utils = require("utils")

return {
  {
    "nvim-notify",
    event = "UIEnter",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true, })
        end,
        desc = "Dismiss notifications",
      },
    },
    after = function()
      require("notify").setup({
        timeout = 2000,
        max_height = math.floor(vim.o.lines * 0.75),
        max_width = math.floor(vim.o.columns * 0.75),
      })
    end,
  },
  {
    "bufferline.nvim",
    event = "UIEnter",
    keys = {
    },
    after = function()
      local icons = utils.icons.diagnostics
      require("bufferline").setup({
        options = {
          close_command = function(n)
            require("mini.bufremove").delete(n, false)
          end,
          middle_mouse_command = function(n)
            require("mini.bufremove").delete(n, false)
          end,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(_, _, diag)
            local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                .. (diag.warning and icons.Warn .. diag.warning or "")
            return vim.trim(ret)
          end,
          always_show_bufferline = false,
        },
      })
    end,
  },
  {
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
}

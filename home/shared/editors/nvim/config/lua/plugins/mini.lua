return {
  {
    "mini.comment",
    event = "DeferredUIEnter",
    after = function()
      require("lz.n").trigger_load("ts_context_commentstring.internal")
      local tscc = require("ts_context_commentstring.internal")
      require("mini.comment").setup({
        options = {
          ignore_blank_line = true,
          custom_commentstring = function()
            return tscc.calculate_commentstring() or vim.bo.commentstring
          end,
        },
      })
    end,
  },
  {
    "mini.nvim",
    keys = {
      {
        "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Close buffer"
      }
    },
  }
}

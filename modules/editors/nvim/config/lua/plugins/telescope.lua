return {
   {
      "nvim-telescope/telescope.nvim",
      dependencies = {
         "nvim-lua/plenary.nvim",
         { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
      },
      config = function()
         require("telescope").setup({
            defaults = {
               mappings = {
                  i = {
                     ["<C-u>"] = false,
                     ["<C-d>"] = false,
                  },
               },
            },
         })

         pcall(require("telescope").load_extension, "fzf")

         local map = require("helpers.keys").map

         -- TODO: Mappings
      end
   }
}

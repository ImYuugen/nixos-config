return {
   {
      "folke/which-key.nvim",
      config = function()
         local wk = require("which-key")
         wk.setup()
         wk.register({
            ["<leader>"] = {
               d = "Debug",
               f = "File",
               g = "Git",
               l = "LSP",
               u = "UI",
            },
         })
      end
   }
}

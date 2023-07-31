-- Autocompletions
return {
   {
      "hrsh7th/nvim-cmp",
      dependencies = {
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-nvim-lua",
	     "hrsh7th/cmp-buffer",
	     "hrsh7th/cmp-path",
	     "L3MON4D3/LuaSnip",
	     "saadparwaiz1/cmp_luasnip",
	     "rafamadriz/friendly-snippets",
      },
      config = function()
         local cmp = require("cmp")
         local luasnip = require("luasnip")

         -- TODO: Stuff
      end,
   },
}

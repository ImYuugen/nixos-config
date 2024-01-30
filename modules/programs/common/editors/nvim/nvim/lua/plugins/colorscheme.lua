return {
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = true,
  --   opts = { style = "night" },
  -- },
  --
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   lazy = true,
  --   priority = 1000,
  --   opts = { variant = "main" },
  -- },
  --
  -- {
  --   "AlexvZyl/nordic.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function ()
  --     require("nordic").load()
  --   end
  -- }
  -- 
  -- {
  --   "oxfist/night-owl.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme("night-owl")
  --   end
  -- }
  --
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = { "italic" },
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          mini = { enabled = true },
        }
      })

      vim.cmd.colorscheme("catppuccin")
    end
  }
}


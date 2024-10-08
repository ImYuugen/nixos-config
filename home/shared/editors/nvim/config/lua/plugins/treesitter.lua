return {
  {
    "nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    after = function(_)
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["a#"] = "@comment.outer",
              ["i#"] = "@comment.inner",
              ["as"] = "@scope.outer",
              ["is"] = "@scope.inner",
            },
          },
        },
        auto_install = false,
        incremental_selection = {
          enable = true,
          keymaps = {
            scope_incremental = false,
          },
        },
      })
    end,
  }
}

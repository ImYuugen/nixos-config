return {
  {
    "nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    after = function(_)
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true, },
        indent = { enable = true, },
        auto_install = false,
        incremental_selection = {
          enable = true,
          keymaps = {
            scope_incremental = false,
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            node_decremental = "<C-space>",
          },
        },
      })
    end,
  }
}

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "Cargo.toml",
  callback = function()
    local opts = function(desc)
      return { silent = true, buffer = true, desc = desc }
    end
    local k = vim.keymap
    k.set("n", "<leader>cu", require("crates").update_crate, opts("Update cargo crate"))
    k.set("n", "<leader>ca", require("crates").update_all_crates, opts("Update all cargo crates"))
    k.set("v", "<leader>cu", require("crates").update_crates, opts("Update selected cargo crates"))
  end,
})

return {
  {
    "crates.nvim",
    event = "BufRead Cargo.toml",
    after = function()
      require("crates").setup()
    end
  },
}

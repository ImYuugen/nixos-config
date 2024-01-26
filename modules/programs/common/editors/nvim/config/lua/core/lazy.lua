local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- IMPORTANT: The loading of specs is ORDERED, anything extending "plugins" must be listed AFTER
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.langs" },
  },
  checker = { enabled = true },
})

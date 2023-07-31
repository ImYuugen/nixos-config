local opts = {
   syntax = "on",
   tabstop = 4,
   shiftwidth = 4,
   shiftround = true,
   expandtab = true,
   smarttab = true,
   autoindent = true,

   mouse = "a",
   backspace = "indent,eol,start",

   smartcase = true,
   ignorecase = true,
   incsearch = true,
   hlsearch = false,

   number = true,
   relativenumber = true,

   termguicolors = true,
}

for opt, val in pairs(opts) do
   vim.opt[opt] = val
end

vim.api.nvim_create_autocmd("FileType", {
   pattern = "lua",
   callback = function()
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
   end,
})

vim.api.nvim_create_autocmd("FileType", {
   pattern = "nix",
   callback = function()
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
   end,
})

local colorscheme = require("helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)


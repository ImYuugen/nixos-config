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

local colorscheme = require("helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)


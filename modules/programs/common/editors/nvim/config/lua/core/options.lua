vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.backspace = "indent,eol,start"
opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.expandtab = true
opt.formatoptions:remove({ "c", "r", "o" })
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.list = true
opt.listchars = { trail = "-" }
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 5
opt.shiftround = true
opt.shiftwidth = 4
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.undodir = "/home/yuugen/.nvim/undo_dir/"
opt.undofile = true
opt.undolevels = 10000
opt.wildmode = "longest:full,full"
opt.wrap = false

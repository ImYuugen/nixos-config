local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

opt.backspace = "indent,eol,start"
opt.cursorline = true
opt.expandtab = true
opt.formatoptions:remove({ "c", "r", "o" })
opt.inccommand = "nosplit"
opt.list = true
opt.listchars = { trail = "-" }
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 5
opt.shiftround = true
opt.shiftwidth = 4
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.undodir = os.getenv("HOME") .. "/.nvim/undo_dir/"
opt.undofile = true
opt.undolevels = 10000
opt.wildmode = "longest:full,full"
opt.wrap = false

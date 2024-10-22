require("config.options")
require("config.mappings")

local lz = require("lz.n")
lz.load("plugins")
require("plugins.langs")

vim.cmd.colorscheme("rose-pine")

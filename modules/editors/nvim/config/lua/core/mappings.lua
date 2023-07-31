local map = require("helpers.keys").map

map("n", "<S-h>", ":bprevious<cr>", "Go to previous buffer")
map("n", "<S-l>", ":bnext<cr>", "Go to next buffer")

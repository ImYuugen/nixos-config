local map = vim.keymap.set

-- Remove search highlights
map("n", "<Esc>", "<Cmd>noh<cr>", { silent = true })

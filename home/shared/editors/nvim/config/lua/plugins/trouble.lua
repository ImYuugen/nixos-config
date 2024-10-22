return {
	"trouble.nvim",
	cmd = "Trouble",
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<CR>",
			desc = "Diagnostics",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>xl",
			"<cmd>Trouble loclist toggle<CR>",
			desc = "Location list",
		},
		{
			"<leader>xq",
			"<cmd>Trouble qflist toggle<CR>",
			desc = "Quickfix list",
		},
	},
	after = function()
		require("trouble").setup({})
	end,
}

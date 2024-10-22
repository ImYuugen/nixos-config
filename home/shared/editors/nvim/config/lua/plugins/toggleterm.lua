return {
	"toggleterm.nvim",
	keys = {
		"<C-/>",
	},
	after = function()
		require("toggleterm").setup({
			open_mapping = [[<C-/>]],
			direction = "float",
		})
	end,
}

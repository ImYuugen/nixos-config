return {
	"nvim-notify",
	event = "UIEnter",
	keys = {
		{
			"<leader>un",
			function()
				require("notify").dismiss({ silent = true, pending = true })
			end,
			desc = "Dismiss notifications",
		},
	},
	after = function()
		require("notify").setup({
			timeout = 2000,
			max_height = math.floor(vim.o.lines * 0.75),
			max_width = math.floor(vim.o.columns * 0.75),
		})
	end,
}

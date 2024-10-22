return {
	"neo-tree.nvim",
	cmd = "Neotree",
	keys = {
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
			end,
			desc = "Open file tree",
		},
	},
	after = function()
		require("neo-tree").setup({
			close_if_last_window = true,
		})
	end,
}

return {
	"gitsigns.nvim",
	event = "DeferredUIEnter",
	keys = {
		{ "<leader>gb", require("gitsigns").toggle_current_line_blame, desc = "Blame line" },
		{
			"<leader>gB",
			function()
				require("gitsigns").blame()
			end,
			desc = "Blame file",
		},
	},
	after = function()
		require("gitsigns").setup({})
	end,
}

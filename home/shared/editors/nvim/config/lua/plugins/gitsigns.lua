return {
	"gitsigns.nvim",
	event = "DeferredUIEnter",
	keys = {
		{ "<leader>g", desc = "Git" },
		{ "<leader>gb", require("gitsigns").toggle_current_line_blame, desc = "Blame line" },
		{
			"<leader>gB",
			function()
				require("gitsigns").blame()
			end,
			desc = "Blame file"
		},
		{
			"<leader>gd",
			require("gitsigns").diffthis,
			desc = "Show diff"
		},
	},
	after = function()
		require("gitsigns").setup({})
	end,
}

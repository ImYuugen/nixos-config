return {
	"nvim-spectre",
	keys = {
		{
			"<leader>sr",
			function()
				require("spectre").open()
			end,
			desc = "Search and Replace",
		},
	},
}

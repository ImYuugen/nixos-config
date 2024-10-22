return {
	"nvim-navbuddy",
	keys = {
		{
			"<leader>nb",
			function()
				require("nvim-navbuddy").open()
			end,
			desc = "Navbuddy",
		},
	},
	after = function()
		require("nvim-navbuddy").setup({
			lsp = {
				auto_attach = true,
			},
		})
	end,
}

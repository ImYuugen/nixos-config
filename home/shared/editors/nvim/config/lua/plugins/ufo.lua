return {
	"nvim-ufo",
	event = "BufEnter",
	keys = {
		{ "zR", require("ufo").openAllFolds },
		{ "zM", require("ufo").closeAllFolds },
	},
	after = function()
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})
	end,
}

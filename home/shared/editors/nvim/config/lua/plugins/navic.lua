return {
	"nvim-navic",
	after = function()
		require("nvim-navic").setup({
			highlight = true,
			click = true, -- Heresy
			lsp = {
				auto_attach = true,
			},
		})
	end,
}

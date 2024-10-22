return {
	"indent-blankline.nvim",
	after = function()
		require("ibl").setup({
			viewport_buffer = { min = 100 },
			indent = {
				char = "▏",
				tab_char = "▏",
			},
			scope = {
				enabled = false,
			},
		})
	end,
}

return {
	"conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format buffer",
			mode = "n",
		},
	},
	after = function()
		local c = require("conform")
		c.setup({
			default_format_opts = { lsp_format = "fallback" },
			formatters_by_ft = {}, -- Configured in langs/<language>.lua
		})
	end,
}

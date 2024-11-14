return {
	"todo-comments.nvim",
	keys = {
		{
			"<leader>xt",
			desc = "Todo Comments",
			icon = { icon = " " },
		},
		{
			"<leader>xt<Space>",
			"<cmd>TodoTelescope<CR>",
			desc = "Telescope",
		},
		{
			"<leader>xtq",
			"<cmd>TodoQuickFix<CR>",
			desc = "Quickfix",
		},
		{
			"<leader>xtT",
			"<cmd>TodoTelescope keywords=TODO<CR>",
			desc = "Telescope - TODO",
		},
		{
			"<leader>xtF",
			"<cmd>TodoTelescope keywords=FIX,FIXME,FIXIT,ISSUE,BUG<CR>",
			desc = "Telescope - FIX",
		},
	},
	after = function()
		require("todo-comments").setup()
	end,
}

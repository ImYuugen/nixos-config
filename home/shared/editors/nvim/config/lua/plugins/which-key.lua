return {
	"which-key.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("which-key").setup({
			preset = "helix",
			spec = {
				{
					mode = { "n" },
					{ "<leader>b", group = "Buffers", icon = { icon = " " } },
					{ "<leader>n", group = "Navigation", icon = { icon = "󰆋 " } },
					{ "<leader>t", group = "Telescope" },
					{ "<leader>x", group = "Diagnostics", icon = { icon = " " } },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "z", group = "fold" },
				},
			},
		})
	end,
}

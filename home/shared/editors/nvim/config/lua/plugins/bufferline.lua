local utils = require("utils")

return {
	"bufferline.nvim",
	event = "UIEnter",
	keys = {
		{ "<leader>bl", ":BufferLineCycleNext<CR>", desc = "Go to right buffer" },
		{ "<leader>bh", ":BufferLineCyclePrev<CR>", desc = "Go to left buffer" },
	},
	after = function()
		local icons = utils.icons.diagnostics
		require("bufferline").setup({
			options = {
				close_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				middle_mouse_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(_, _, diag)
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				always_show_bufferline = false,
			},
		})
	end,
}

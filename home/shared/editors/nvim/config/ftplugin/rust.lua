-- FORMATTER
require("conform").formatters_by_ft.nix = { "nix fmt" }
-- END FORMATTER
-- KEYMAPS
local wk = require("which-key")
wk.add({
	{ "<leader>r", "", desc = "Rust", mode = "n" },
	{
		"<leader>ra",
		function()
			vim.cmd.RustLsp("codeAction")
		end,
		desc = "Code actions",
		mode = "n",
	},
	{
		"<leader>rd",
		function()
			vim.cmd.RustLsp("debuggables")
		end,
		desc = "Debuggables",
		mode = "n",
	},
	{
		"<leader>rD",
		function()
			vim.cmd.RustLsp({ "debuggables", bang = true })
		end,
		desc = "Last debuggable",
		mode = "n",
	},
	{
		"<leader>rr",
		function()
			vim.cmd.RustLsp("runnables")
		end,
		desc = "Runnables",
		mode = "n",
	},
	{
		"<leader>rR",
		function()
			vim.cmd.RustLsp({ "runnables", bang = true })
		end,
		desc = "Last runnable",
		mode = "n",
	},
	{
		-- TODO: Autofocus
		"<leader>rh",
		function()
			vim.cmd.RustLsp({ "hover", "actions" })
		end,
		desc = "Hover actions",
		mode = "n",
	},
	{
		"<leader>rE",
		function()
			vim.cmd.RustLsp("explainError")
		end,
		desc = "Explain error",
		mode = "n",
	},
	{
		"<leader>rK",
		function()
			vim.cmd.RustLsp("openDocs")
		end,
		desc = "Open docs.rs documentation",
		mode = "n",
	},
})
-- END KEYMAPS

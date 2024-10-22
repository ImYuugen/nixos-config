return {
	"telescope.nvim",
	keys = {
		{
			"<leader><space>",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Find files",
		},
		{
			"<leader>/",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Grep files",
		},
		{
			"<leader>bb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>ts",
			function()
				require("telescope.builtin").lsp_dynamic_workspace_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"gr",
			function()
				require("telescope.builtin").lsp_references()
			end,
			desc = "Go to references",
		},
		{
			"gd",
			function()
				require("telescope.builtin").lsp_definitions()
			end,
			desc = "Go to definitions",
		},
	},
	after = function()
		local ts = require("telescope")
		ts.setup({
			defaults = {
				path_display = { "truncate" },
				preview = {
					treesitter = true,
				},
				color_devicons = true,
				set_env = { ["COLORTERM"] = "truecolor" },
				prompt_prefix = " ",
				selection_caret = "> ",
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			},
		})
		ts.load_extension("fzf")
	end,
}

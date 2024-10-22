return {
	"nvim-cmp",
	event = "DeferredUIEnter",
	after = function()
		require("lz.n").trigger_load("lspkind.nvim")

		local cmp = require("cmp")
		local lspkind = require("lspkind")
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					with_text = true,
					maxwidth = 50,
					ellipsis_char = "...",
					menu = {
						nvim_lsp = "[LSP]",
						nvim_lsp_signature_help = "[LSP]",
						nvim_lsp_document_symbol = "[LSP]",
						nvim_lua = "[API]",
						path = "[PATH]",
						buffer = "[BUF]",
						luasnip = "[SNIP]",
					},
				}),
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = {
				["<A-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Replace }),
				["<A-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Replace }),
				["<A-h>"] = cmp.mapping.scroll_docs(-4),
				["<A-l>"] = cmp.mapping.scroll_docs(4),
				["<A-f>"] = cmp.mapping.complete(),
				["<A-e>"] = cmp.mapping.abort(),
				["<A-s>"] = cmp.mapping.confirm({
					select = true,
					behavior = cmp.ConfirmBehavior.Replace,
				}),
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "crates" },
				{ name = "async_path", trigger_characters = { "./", "/" } },
				{ name = "treesitter" },
			},
		})

		vim.keymap.set({ "i", "c", "s" }, "<C-n>", cmp.complete, { noremap = false, desc = "Complete" })
	end,
}

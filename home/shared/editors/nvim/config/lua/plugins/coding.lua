return {
  {
    "nvim-cmp",
    event = "DeferredUIEnter",
    after = function()
      require("lz.n").trigger_load("lspkind.nvim")

      local cmp = require("cmp")
      local lspkind = require("lspkind")
      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            with_text = true,
            maxwidth = 50,
            ellipsis_char = "...",
            menu = {
                buffer = "[BUF]",
                nvim_lsp = "[LSP]",
                nvim_lsp_signature_help = "[LSP]",
                nvim_lsp_document_symbol = "[LSP]",
                nvim_lua = "[API]",
                path = "[PATH]",
                luasnip = "[SNIP]",
            },
          }),
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<A-CR>"] = cmp.mapping.confirm({ select = true, }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer", keyword_length = 3, },
          { name = "crates" },
          { name = "async_path", trigger_characters = { "./", "/" }, },
          { name = "treesitter" },
        },
      })
    end
  }
}

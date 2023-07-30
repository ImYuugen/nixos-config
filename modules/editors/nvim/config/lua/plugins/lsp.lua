return {
   {
      "neovim/nvim-lspconfig",
      dependencies = {
         "williamboman/mason.nvim",
         "williamboman/mason-lspconfig.nvim",
         "j-hui/fidget.nvim",
         "folke/neodev.nvim",
         "RRethy/vim-illuminate",
         "hrsh7th/cmp-nvim-lsp",
      },
      config = function()
         require("mason").setup()
         require("mason-lspconfig").setup({
            ensure_installed = {
               "bashls", --BASH
               "clangd", --C/C++
               "lua_ls", --LUA
               "nil_ls" --NIX
               "rust_analyzer", --RUST
               "taplo", --TOML
            },
            automatic_installation = true,
         })

         require("helpers.keys").map("n", "<leader>m", "<cmd>Mason<cr>", "Show Mason")
         require("neodev").setup()
         require("fidget").setup()

         local signs = { Error = "E ", Warn = "W ", Hint = "H ", Info = "I " }, --TODO: Find icons
         for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
         end

         local config = {
            virtual_text = false,
            signs = { active = signs, },
            update_in_insert = true,
            underline = true,
            severity_sort = true,
            float = {
               focusable = true,
               style = "minimal",
               border = "rounded",
               source = "always",
               header = "",
               prefix = "",
            },
         }
         vim.diagnostic.config(config)

         local on_attach = function(client, bufnr)
            local lsp_map = require("helpers.keys").lsp_map

            lsp_map("<leader>lr", vim.lsp.rename, "Rename symbol")
            lsp_map("<leader>la", vim.lsp.code_action, bufnr, "Code action")
            lsp_map("<leader>ld", vim.lsp.definition, "Type definition")
            lsp_map("<leader>ls", require("telescope.builtin").lsp_document_symbols, bufnr, "Document symbols")

            lsp_map("gd", vim.lsp.buf.definition, bufnr, "Goto definition")
            lsp_map("gr", require("telescope.builtin").lsp_references, bufnr, "Goto References")
			lsp_map("gi", vim.lsp.buf.implementation, bufnr, "Goto Implementation")
			lsp_map("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
			lsp_map("gD", vim.lsp.buf.declaration, bufnr, "Goto Declaration")

            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
               vim.lsp.buf.format()
            end, { desc = "Format current buffer" })

            lsp_map("<leader>ff", "<cmd>Format<cr>", bufnr, "Format")

            require("illuminate").on_attach(client)
         end

         local capabilities = vim.lsp.protocol.make_client_capabilities()
         capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

         require("lspconfig")["lua_ls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
               Lua = {
                  completion = {
                     callSnippet = "Replace",
                  },
                  diagnostics = {
                     globals = { "vim" },
                  },
                  workspaces = {
                     library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.stdpath("config") .. "/lua"] = true,
                     },
                  },
               },
            },
         })

         require("lspconfig")["rust_analyzer"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
         })

         require("lspconfig")["nil_ls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
         })
      end
   }
}

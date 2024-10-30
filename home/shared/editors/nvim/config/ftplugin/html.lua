if vim.fn.executable("vscode-html-language-server") ~= 1 then
	return
end

local caps = vim.lsp.protocol.make_client_capabilities()
caps.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").html.setup({
	capabilities = caps,
	autostart = true,
	filetypes = { "html", "htmlangular", "templ" },
})

return {}

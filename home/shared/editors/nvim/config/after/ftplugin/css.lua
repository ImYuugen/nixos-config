if vim.fn.executable("vscode-css-language-server") ~= 1 then
	return
end

local caps = vim.lsp.protocol.make_client_capabilities()
caps.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").cssls.setup({
	capabilities = caps,
	autostart = true,
})

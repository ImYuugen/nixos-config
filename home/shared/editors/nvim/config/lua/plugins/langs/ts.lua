local util = require("lspconfig.util")
local bin = "typescript-language-server"

if vim.fn.executable(bin) ~= 1 then
	return
end

local root_files = {
	"tsconfig.json",
	"jsconfig.json",
	"package.json",
	".git",
}

require("lspconfig").ts_ls.setup({
	init_options = {
		plugins = {},
	},
})

local conform = require("conform")
conform.formatters.prettierd = {
	prepend_args = { "--tab-width", "4" },
}
conform.formatters.prettier = {
	prepend_args = { "--tab-width", "4" },
}

local formatter = { "prettierd", "prettier", stop_after_first = true }
local ts_variants = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "json5", "jsonc" }
for _, variant in ipairs(ts_variants) do
	conform.formatters_by_ft[variant] = formatter
end

return {}

-- LSP
do
	local bin = "typescript-language-server"

	if vim.fn.executable(bin) ~= 1 then
		return
	end

	require("lspconfig").ts_ls.setup({
		init_options = {
			plugins = {},
		},
	})
end
-- END LSP

-- FORMATTER
do
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
end
-- END FORMATTER

-- DEBUG ADAPTER
do
	local dap = require("dap")
	local adapter = "js-debug"
	local get_adapter = function()
		local path = vim.fn.exepath(adapter)
		-- Strip /js-debug from end of string
		path = path:gsub("/" .. adapter, "")
		-- Add relative path to dapDebugServer.js
		print(path .. "../../lib/node_modules/js-debug/dist/src/dapDebugServer.js")
		return path .. "../../lib/node_modules/js-debug/dist/src/dapDebugServer.js"
	end
	if vim.fn.executable(adapter) then
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = { get_adapter(), "${port}" },
			},
		}
	end
	dap.configurations.javascript = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
	}
end
-- END DEBUG ADAPTER

return {}

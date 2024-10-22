return {
	{
		"nvim-dap",
		keys = {
			{ "<leader>d", "", desc = "Debug", mode = { "n", "v" } },
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Continue",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Step over",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "Step out",
			},
			{
				"<leader>dj",
				function()
					require("dap").down()
				end,
				desc = "Down",
			},
			{
				"<leader>dk",
				function()
					require("dap").up()
				end,
				desc = "Up",
			},
			{
				"<leader>dw",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "Widgets",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Toggle REPL",
			},
		},
		after = function()
			local dap = require("dap")
			dap.configurations = {}
		end,
	},
	{
		"nvim-dap-ui",
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle({})
				end,
				desc = "Dap UI",
			},
			{
				"<leader>de",
				function()
					require("dapui").eval()
				end,
				desc = "Eval",
			},
		},
		after = function()
			local dap = require("dap")
			local ui = require("dapui")
			ui.setup({})
			dap.listeners.after.event_initialized["dapui_config"] = function()
				ui.open({})
			end
			dap.listeners.after.event_terminated["dapui_config"] = function()
				ui.close({})
			end
			dap.listeners.after.event_exited["dapui_config"] = function()
				ui.close({})
			end
		end,
	},
	{
		"nvim-dap-virtual-text",
	},
}

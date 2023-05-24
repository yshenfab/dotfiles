-- DAP (Debug Adapter Protocol)
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- debugger UI
			"rcarriga/nvim-dap-ui",
			-- installs debug adapters
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			-- treesitter & telescope support
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
			-- specific languages
			"mfussenegger/nvim-dap-python",
			"leoluz/nvim-dap-go",
		},

		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("mason-nvim-dap").setup({
				automatic_setup = true,
				handlers = {},
				ensure_installed = {
					"delve",
					"cpptools",
				},
			})
			-- Basic debugging keymaps
			vim.keymap.set("n", "<F5>", dap.continue)
			vim.keymap.set("n", "<F6>", dap.terminate)
			vim.keymap.set("n", "<F2>", dap.step_into)
			vim.keymap.set("n", "<F3>", dap.step_over)
			vim.keymap.set("n", "<F4>", dap.step_out)
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
			vim.keymap.set("n", "<leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end)

			-- Dap UI setup
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				controls = {
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "b",
						run_last = "▶▶",
						terminate = "⏹",
					},
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			-- language specific config
			require("dap-python").setup()
			require("dap-go").setup()
		end,
	},
}

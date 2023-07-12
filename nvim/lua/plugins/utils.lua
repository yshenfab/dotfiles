-- utils
return {
	-- fuzzy finder
	{
		{ "junegunn/fzf", build = "./install --all" },
		{ "junegunn/fzf.vim" },
	},

	-- which-key: cheatsheet for pending keybinds
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({})
		end,
	},

	-- harpoon: marks
	{
		"ThePrimeagen/harpoon",
		config = function()
			local nmap = function(tbl)
				vim.keymap.set("n", tbl[1], tbl[2], tbl[3])
			end

			local harpoon = require("harpoon")

			harpoon.setup({})

			-- nmap { "<leader>a", require("harpoon.mark").add_file }
			nmap({ "<leader>a", require("harpoon.mark").toggle_file })
			nmap({ "<C-e>", require("harpoon.ui").toggle_quick_menu })

			-- for i = 1, 5 do
			--   nmap {
			--     string.format("<space>%s", i),
			--     function()
			--       require("harpoon.ui").nav_file(i)
			--     end,
			--   }
			-- end
		end,
	},
}

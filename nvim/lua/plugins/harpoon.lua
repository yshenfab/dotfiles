-- Harpoon
return {
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

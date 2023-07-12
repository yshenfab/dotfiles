-- better editting
return {
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	-- Dot-repeat
	"tpope/vim-repeat",

	-- nvim-surround: add/delete/change surroundings
	-- add: ys{motion}{char}
	-- delete: ds{char}
	-- change: cs{target}{replacement}
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	-- autopairs
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				map_cr = false,
			})
		end,
	},

	-- [[ Motions: leap, filt, hop (easymotion-like) ]]
	-- Leap: jump to any positions in the visible editor area by entering a 2-char search
	-- s/S/gs{c1}{c2}
	{
		"ggandor/leap.nvim",
		keys = {
			{ "s",  mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S",  mode = { "n", "x", "o" }, desc = "Leap backward to" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},
	-- filt: enhanced f/t motions for leap, 1-char search
	-- f/F/t/T{char}
	{
		"ggandor/flit.nvim",
		keys = function()
			---@type LazyKeys[]
			local ret = {}
			for _, key in ipairs({ "f", "F", "t", "T" }) do
				ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
			end
			return ret
		end,
		opts = { labeled_modes = "nx" },
	},
	-- hop: EasyMotion-like plugin
	-- {
	-- 	"phaazon/hop.nvim",
	-- 	version = "v2", -- optional but strongly recommended
	-- 	config = function()
	-- 		require("hop").setup({})
	-- 		local hop = require("hop")
	-- 		local directions = require("hop.hint").HintDirection
	-- 		vim.keymap.set("", "f", function()
	-- 			hop.hint_char1({ direction = directions.AFTER_CURSOR })
	-- 		end, { remap = true })
	-- 		vim.keymap.set("", "F", function()
	-- 			hop.hint_char1({ direction = directions.BEFORE_CURSOR })
	-- 		end, { remap = true })
	-- 		vim.keymap.set("", "s", function()
	-- 			hop.hint_char2({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
	-- 		end, { remap = true })
	-- 		vim.keymap.set("", "S", function()
	-- 			hop.hint_char2({ direction = directions.BEFORE_CURSOR, hint_offset = 1 })
	-- 		end, { remap = true })
	-- 	end,
	-- },

	-- auto highlight other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = { delay = 200 },
		config = function(_, opts)
			require("illuminate").configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end

			map("]]", "next")
			map("[[", "prev")

			-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map("]]", "next", buffer)
					map("[[", "prev", buffer)
				end,
			})
		end,
		keys = {
			{ "]]", desc = "Next Reference" },
			{ "[[", desc = "Prev Reference" },
		},
	},

	-- easy align
	{
		"junegunn/vim-easy-align",
		config = function()
			vim.cmd([[xmap ga <Plug>(EasyAlign)]])
			vim.cmd([[nmap ga <Plug>(EasyAlign)]])
		end,
	},

	-- table mode (<leader>tm or :TableModeToggle)
	"dhruvasagar/vim-table-mode",

	-- multi cursor
	"mg979/vim-visual-multi",
}
-- Fuzzy Finder (files, lsp, etc)
return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
					},
				},
			})
			-- Enable telescope fzf native, if installed
			pcall(require("telescope").load_extension, "fzf")

			local function nmap(lhs, rhs, opts)
				opts = opts or {}
				opts.silent = opts.silent ~= false
				vim.keymap.set("n", lhs, rhs, opts)
			end

			local tele = require("telescope.builtin")

			-- Fuzzy search
			nmap("<leader>/", function()
				tele.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzy search in current buffer" })
			-- MRU, files, buffers, etc.
			nmap("<leader>fo", tele.oldfiles, { desc = "[F]ind [O]ldfiles (MRU)" })
			nmap("<leader>ff", tele.find_files, { desc = "[F]ind [F]iles" })
			nmap("<leader>fb", tele.buffers, { desc = "[F]ind [B]uffers" })
			nmap("<leader>fw", tele.grep_string, { desc = "[F]ind [W]ord" })
			nmap("<leader>fg", tele.live_grep, { desc = "[F]ind by [G]rep (rg)" })
			nmap("<leader>fh", tele.help_tags, { desc = "[F]ind [H]elp tags" })
			-- Diagnostics
			nmap("<leader>fd", tele.diagnostics, { desc = "[F]ind [D]iagnostics" })
			-- History
			nmap("<leader>ch", tele.search_history, { desc = "[C]ommand [H]istory" })
			nmap("<leader>sh", tele.search_history, { desc = "[S]earch [H]istory" })
			-- Git
			nmap("<leader>gf", tele.git_files, { desc = "[G]it [F]iles" })
			nmap("<space>gs", tele.git_status, { desc = "[G]it [S]tatus" })
			nmap("<space>gc", tele.git_commits, { desc = "[G]it [C]ommit" })
			-- Treesittter
			nmap("<leader>ts", tele.treesitter, { desc = "[T]reesitter [S]ymbols" })
			-- Other
			nmap("<leader>vo", tele.vim_options, { desc = "[V]im [O]ptions" })
		end,
	},
	"nvim-telescope/telescope-file-browser.nvim",
	"nvim-telescope/telescope-hop.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"ThePrimeagen/git-worktree.nvim",
		config = function()
			require("git-worktree").setup({})
		end,
	},
	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup()
		end,
	},
}

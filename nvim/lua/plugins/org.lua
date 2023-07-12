-- org-mode
return {
	-- org-mode
	{
		"nvim-orgmode/orgmode",
		config = function()
			require("orgmode").setup_ts_grammar()

			require("nvim-treesitter.configs").setup({
				-- If TS highlights are not enabled at all, or disabled via `disable` prop,
				-- highlighting will fallback to default Vim syntax highlighting
				highlight = {
					enable = true,
					-- Required for spellcheck, some LaTex highlights and
					-- code block highlights that do not have ts grammar
					additional_vim_regex_highlighting = { "org" },
				},
				ensure_installed = { "org" }, -- Or run :TSUpdate org
			})

			require("orgmode").setup({
				-- org_agenda_files = { "~/Dropbox/org/*", "~/my-orgs/**/*" },
				-- org_default_notes_file = "~/Dropbox/org/refile.org",
			})
		end,
	},

	-- neorg
	-- {
	-- 	"nvim-neorg/neorg",
	-- 	build = ":Neorg sync-parsers",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("neorg").setup({
	-- 			load = {
	-- 				["core.defaults"] = {}, -- Loads default behaviour
	-- 				["core.concealer"] = {}, -- Adds pretty icons to your documents
	-- 				["core.dirman"] = { -- Manages Neorg workspaces
	-- 					config = {
	-- 						workspaces = {
	-- 							notes = "~/OneDrive/notes/",
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
}

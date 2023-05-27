-- code runner
return {
	"michaelb/sniprun",
	config = function()
		require("sniprun").setup({})
		vim.api.nvim_set_keymap("v", "<leader>sr", "<Plug>SnipRun", { silent = true })
		vim.api.nvim_set_keymap("n", "<leader>sr", "<Plug>SnipRun", { silent = true })
	end,
}

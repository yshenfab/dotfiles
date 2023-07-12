-- Comment
return {
	-- Comment: Smart and Powerful commenting plugin
	-- NORMAL mode
	-- gcc: toggle current line using linewise comment
	-- gbc: toggle current line using blockwise comment
	-- [count]gcc: toggle number of lines given using linewise comment
	-- [count]gbc: toggle number of lines given using blockwise comment
	-- VISUAL mode
	-- gc: toggle the region use linewise comment
	-- gb: toggle the region use blockwise comment
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- todo-comments: Highlight, list and search todo comments like TODO, FIXME, HACK, BUG, NOTE, FIX, WARNING, etc.
	-- TODO:
	-- FIXME:
	-- NOTE:
	-- BUG:
	-- FIX:
	-- WARNING:
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
		-- stylua: ignore
		keys = {
			{ "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
			{
				"[t",
				function() require("todo-comments").jump_prev() end,
				desc =
				"Previous todo comment"
			},
			{ "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
			{
				"<leader>xT",
				"<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",
				desc =
				"Todo/Fix/Fixme (Trouble)"
			},
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "[S]earch [t]odo" },
			{
				"<leader>sT",
				"<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",
				desc =
				"[S]earch [T]odo/Fix/Fixme"
			},
		},
	},
}

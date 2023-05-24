-- [[ Autocmd ]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = augroup("YankHighlight", { clear = true }),
	pattern = "*",
})

-- Wrap and check for spell in text filetypes
autocmd("FileType", {
	group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
	pattern = { "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Remove whitespace on save
autocmd("BufWritePre", {
	pattern = "",
	command = ":%s/\\s\\+$//e",
})

-- Disable auto-comment for new lines
autocmd("BufEnter", {
	pattern = "",
	command = ":setlocal formatoptions-=cro",
})

-- Autoformat
vim.cmd("autocmd BufWritePre * lua vim.lsp.buf.format()")

-- isort on save
autocmd("BufWritePre", {
	pattern = "*.py",
	callback = function()
		vim.cmd("silent :Isort")
	end,
})

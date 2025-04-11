-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "

vim.g.snacks_animate = false

vim.opt.cmdheight = 0

-- vim.g.loaded_python3_provider = 0
vim.g.lazyvim_python_lsp = "pyright" -- basedpyright
vim.g.lazyvim_python_ruff = "ruff"

vim.g.lazyvim_picker = "fzf" -- telescope
-- vim.env.FZF_DEFAULT_OPTS = ""

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Terminal window navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", { desc = "Go to left window" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", { desc = "Go to left window" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", { desc = "Go to left window" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", { desc = "Go to left window" })

-- mapping for paste, replace a word with yanked text
-- map("x", "<leader>p", [["_dP]])

-- insert mode movements (borrowed from NvChad)
vim.keymap.set("i", "<C-a>", "<Esc>^i", { desc = "Beginning of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "End of line" })
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })

vim.keymap.set("n", "<C-c>", "ciw")

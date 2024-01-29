-- [[ autocmd ]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- highlight on yank
autocmd("TextYankPost", {
  group = augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- wrap and check for spell in text filetypes
autocmd("FileType", {
  group = augroup("wrap_spell", { clear = true }),
  pattern = { "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- disable auto-comment for new lines
autocmd("BufEnter", {
  pattern = "",
  command = ":setlocal formatoptions-=cro",
})

-- auto-format on save
vim.cmd("autocmd BufWritePre * lua vim.lsp.buf.format()")

-- auto change current working directory
vim.cmd("autocmd BufEnter * lcd %:p:h")

-- linting
-- autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
--   group = augroup("lint", { clear = true }),
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })

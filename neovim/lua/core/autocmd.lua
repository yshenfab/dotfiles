-- [[ Autocmd ]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Autoformat
vim.cmd('autocmd BufWritePre * lua vim.lsp.buf.format()')

-- Highlight on yank
autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = augroup('YankHighlight', { clear = true }),
    pattern = '*',
})

-- Wrap and check for spell in text filetypes
autocmd("FileType", {
    group = vim.api.nvim_create_augroup('wrap_spell', { clear = true }),
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Remove whitespace on save
autocmd('BufWritePre', {
    pattern = '',
    command = ":%s/\\s\\+$//e"
})

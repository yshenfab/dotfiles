-- markdown
return {
  -- markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    config = function()
      vim.cmd([[nmap <C-p> :MarkdownPreviewToggle<cr>]])
    end,
  },
  -- markdown-toc
  -- :GenTocGFM   GFM (GitHub Flavored Markdown)
  {
    "mzlogin/vim-markdown-toc",
  },
}

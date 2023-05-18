-- LaTeX
return {
  -- vimtex, default keymap prefix: <leader>l
  {
    'lervag/vimtex',
    config = function()
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_view_general_viewer = 'okular'
      vim.g.vimtex_imaps_enabled = 0
      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_syntax_conceal_disable = 1
      vim.g.vimtex_quickfix_enabled = 1
      vim.g.vimtex_quickfix_mode = 0
    end,
    ft = "tex",
  },
  -- latex symbols support for nvim-cmp
  "kdheepak/cmp-latex-symbols",
}

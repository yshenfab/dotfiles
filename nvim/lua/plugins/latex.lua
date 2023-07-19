-- LaTeX
return {
  -- vimtex, default keymap prefix: <leader>l
  {
    "lervag/vimtex",
    ft = "tex", -- Lazy-load on filetype
    config = function()
      vim.g.vimtex_compiler_method = "latexmk"
      -- vim.g.vimtex_view_general_viewer = 'okular'
      vim.g.vimtex_imaps_enabled = 1
      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_syntax_conceal_disable = 1
      vim.g.vimtex_quickfix_enabled = 1
      vim.g.vimtex_quickfix_mode = 0
    end,
  },

  -- latex symbols support for nvim-cmp
  {
    "kdheepak/cmp-latex-symbols",
    -- event = "VeryLazy",
    ft = "tex",
  },
}

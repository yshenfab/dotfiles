-- colorscheme, check https://vimcolorschemes.com/
return {
  { "folke/tokyonight.nvim" },
  { "catppuccin/nvim",         name = "catppuccin" },
  { "ellisonleao/gruvbox.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "rose-pine/neovim",        name = "rose-pine" },
  { 'tanvirtin/monokai.nvim' },
  {
    'navarasu/onedark.nvim',
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
}

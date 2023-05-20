-- Git related
return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
    },
    config = function()
      require('gitsigns').setup()
    end
  },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
}

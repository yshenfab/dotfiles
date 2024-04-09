-- colorschemes
-- https://vimcolorschemes.com/
return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- load during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd.colorscheme("tokyonight-moon")
    end,
  },
  -- { "catppuccin/nvim", name = "catppuccin" },
  -- { "rose-pine/neovim", name = "rose-pine" },
  -- { "ellisonleao/gruvbox.nvim" },
  -- { "EdenEast/nightfox.nvim" },
  -- { "tanvirtin/monokai.nvim" },
  -- { "navarasu/onedark.nvim" },
}

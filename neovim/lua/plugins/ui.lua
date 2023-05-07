-- UI related: lualine, bufferline, indent-blankline
return {
  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
    config = function()
      require('lualine').setup {}
    end
  },
  -- bufferline
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        vim.keymap.set('n', "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle pin" }),
        vim.keymap.set('n', "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>",
          { desc = "Delete non-pinned buffers" })
      }
    end
  },
  -- indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '|',
      show_trailing_blankline_indent = false,
      show_current_context = true,
    },
  },
}

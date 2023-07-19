-- terminal
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = { { "<leader>tt", mode = "n", desc = "Toggle Terminal" } },
  opts = {
    size = 10,
    open_mapping = [[<leader>tt]],
    shade_terminals = true,
    shading_factor = 2,
    direction = "horizontal", -- or vertical, tab, float
  },
}

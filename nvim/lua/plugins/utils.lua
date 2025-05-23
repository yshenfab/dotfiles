return {
  -- file manager
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      {
        "<leader>fm",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "File manager (root dir)",
      },
      {
        "<leader>fM",
        "<cmd>Yazi cwd<cr>",
        desc = "File manager (cwd)",
      },
    },
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
  -- project
  -- {
  --   "ahmedkhalf/project.nvim",
  --   opts = {
  --     manual_mode = false, -- use :ProjectRoot manually
  --   },
  -- },
  -- undotree
  {
    "mbbill/undotree",
    keys = { { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" } },
  },
}

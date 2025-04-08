-- file explorer tree
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<leader>tn", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" },
      { "\\", "<cmd>Neotree reveal_force_cwd<cr>", desc = "NeoTree cwd" },
    },
    config = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
      require("neo-tree").setup({
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
        sort_case_insensitive = false,
        sort_function = nil,
        window = {
          position = "left",
          width = 20,
        },
        autochdir = true,
      })
    end,
  },
}

-- trouble
-- showing diagnostics, references, telescope results, quickfix & location lists
return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  opts = { use_diagnostic_signs = true },
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle<cr>",                       desc = "Trouble Toggle" },
    { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
    { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    { "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
    { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
    { "gR",         "<cmd>TroubleToggle lsp_reference<cr>",         desc = "LSP Reference (Trouble)" },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").previous({ skip_groups = true, jump = true })
        else
          vim.cmd.cprev()
        end
      end,
      desc = "Previous trouble/quickfix item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          vim.cmd.cnext()
        end
      end,
      desc = "Next trouble/quickfix item",
    },
  },
}

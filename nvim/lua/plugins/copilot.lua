-- AI Coding Assistant
return {
  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- Tabnine
  -- {
  --   "codota/tabnine-nvim", -- official plugin
  --   build = "./dl_binaries.sh",
  --   config = function()
  --     require("tabnine").setup({
  --       disable_auto_comment = true,
  --       accept_keymap = "<Tab>",
  --       dismiss_keymap = "<C-]>",
  --       debounce_ms = 800,
  --       suggestion_color = { gui = "#808080", cterm = 244 },
  --       exclude_filetypes = { "TelescopePrompt" },
  --       log_file_path = nil,
  --     })
  --   end,
  -- },
  {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    event = "InsertEnter",
  },

  -- Codeium
  -- "Exafunction/codeium.vim", -- official plugin
  {
    "jcdickinson/codeium.nvim",
    event = "InsertEnter",
    config = function()
      require("codeium").setup()
    end,
  },

  -- Bito
  {
    "zhenyangze/vim-bitoai",
    event = "VeryLazy",
    config = function()
      -- show in buffers list
      vim.g.bito_buffer_name_prefix = vim.g.bito_buffer_name_prefix or "bito_history_"
      -- change bito path if bito cli is not sys command
      vim.g.vim_bito_path = vim.g.vim_bito_path or "bito"
      -- change results of bito, like: "translate the comment into chinese", "write the comment in chinese"
      vim.g.vim_bito_prompt_append = vim.g.vim_bito_prompt_append or ""
    end,
  },

  -- huggingface
  -- two commands: HFccSuggestion, HFccToggleAutoSuggest
  -- {
  --   "huggingface/hfcc.nvim",
  --   opts = {
  --     api_token = "your_token",
  --     model = "bigcode/starcoder",
  --     query_params = {
  --       max_new_tokens = 200,
  --       temperature = 0.2,
  --       top_p = 0.95,
  --       stop_token = "<|endoftext|>",
  --     },
  --   },
  --   debounce_ms = 80,
  --   -- accept_keymap = "<Tab>",
  --   -- dismiss_keymap = "<S-Tab>",
  --   keys = { { "<leader>cs", "<cmd>HFccSuggestion<cr>", desc = "Code Suggestion" } },
  -- },
}

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
    -- event = { "InsertEnter", "LspAttach" }, -- event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or  "github/copilot.vim"
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {},
    keys = {
      { "<leader>cc", mode = { "n", "o" }, "<cmd>CopilotChat<cr>", desc = "CopilotChat" },
      { "<leader>cp", mode = { "n", "o" }, "<cmd>CopilotChatPrompts<cr>", desc = "CopilotChatPrompts" },
      { "<leader>cm", mode = { "n", "o" }, "<cmd>CopilotChatModels<cr>", desc = "CopilotChatModels" },
      { "<leader>ca", mode = { "n", "o" }, "<cmd>CopilotChatAgents<cr>", desc = "CopilotChatAgents" },
      { "<leader>tc", "<cmd>CopilotChatToggle<cr>", desc = "Toggle CopilotChat" },
    },
  },

  -- avante
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        temperature = 0,
        max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
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
  -- {
  --   "tzachar/cmp-tabnine",
  --   build = "./install.sh",
  --   event = "InsertEnter",
  -- },

  -- Codeium
  {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end,
  },

  -- cmp-ai
  -- {
  --   "tzachar/cmp-ai",
  --   dependencies = "nvim-lua/plenary.nvim",
  --   config = function()
  --     local cmp_ai = require("cmp_ai.config")
  --
  --     cmp_ai:setup({
  --       max_lines = 100,
  --       provider = "Ollama",
  --       provider_options = {
  --         model = "codellama:7b-code",
  --       },
  --       notify = true,
  --       notify_callback = function(msg)
  --         vim.notify(msg)
  --       end,
  --       run_on_every_keystroke = true,
  --       ignored_file_types = {
  --         -- default is not to ignore
  --         -- uncomment to ignore in lua:
  --         -- lua = true
  --       },
  --     })
  --   end,
  -- },

  -- Bito
  -- {
  --   "zhenyangze/vim-bitoai",
  --   event = "VeryLazy",
  --   config = function()
  --     -- show in buffers list
  --     vim.g.bito_buffer_name_prefix = vim.g.bito_buffer_name_prefix or "bito_history_"
  --     -- change bito path if bito cli is not sys command
  --     vim.g.vim_bito_path = vim.g.vim_bito_path or "bito"
  --     -- change results of bito, like: "translate the comment into chinese", "write the comment in chinese"
  --     vim.g.vim_bito_prompt_append = vim.g.vim_bito_prompt_append or ""
  --   end,
  -- },

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

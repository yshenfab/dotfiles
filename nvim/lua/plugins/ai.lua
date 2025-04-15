return {
  -- avante
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = "gemini", -- openai, claude, gemini, copilot, etc.
      -- openai = {
      --   endpoint = "https://api.openai.com/v1",
      --   model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      --   timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      --   temperature = 0,
      --   max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --   --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      -- },
      gemini = {
        -- endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-2.5-pro-exp-03-25", -- gemini-2.0-flash
        -- timeout = 30000, -- Timeout in milliseconds
        -- temperature = 0,
        -- max_tokens = 8192,
      },
      -- copilot = {
      --   endpoint = "https://api.githubcopilot.com",
      --   model = "gpt-4o-2024-08-06",
      --   proxy = nil, -- [protocol://]host[:port] Use this proxy
      --   allow_insecure = false, -- Allow insecure server connections
      --   timeout = 30000, -- Timeout in milliseconds
      --   temperature = 0,
      --   max_tokens = 20480,
      -- },
    },
    -- opts for cursor-planning-mode
    -- opts = {
    --   --- ... existing configurations
    --   provider = "claude", -- In this example, use Claude for planning, but you can also use any provider you want.
    --   cursor_applying_provider = "groq", -- In this example, use Groq for applying, but you can also use any provider you want.
    --   behaviour = {
    --     --- ... existing behaviours
    --     enable_cursor_planning_mode = true, -- enable cursor planning mode!
    --   },
    --   vendors = {
    --     --- ... existing vendors
    --     groq = { -- define groq provider
    --       __inherited_from = "openai",
    --       api_key_name = "GROQ_API_KEY",
    --       endpoint = "https://api.groq.com/openai/v1/",
    --       model = "llama-3.3-70b-versatile",
    --       max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
    --     },
    --   },
    --   --- ... existing configurations
    -- },

    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  },

  -- MCP
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- comment the following line to ensure hub will be ready at the earliest
    cmd = "MCPHub", -- lazy load by default
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = function()
      require("mcphub").setup({
        extensions = {
          avante = {
            make_slash_commands = true, -- make /slash commands from MCP server prompts
          },
        },
      })
    end,
  },
}

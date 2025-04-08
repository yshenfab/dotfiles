-- utils
return {
  -- snacks: A collection of QoL plugins for Neovim
  -- {
  --   "folke/snacks.nvim",
  --   priority = 1000,
  --   lazy = false,
  --   ---@type snacks.Config
  --   opts = {
  --     bigfile = { enabled = true },
  --     dashboard = { enabled = true },
  --     explorer = { enabled = true },
  --     indent = { enabled = true },
  --     input = { enabled = true },
  --     picker = { enabled = true },
  --     notifier = { enabled = true },
  --     quickfile = { enabled = true },
  --     scope = { enabled = true },
  --     scroll = { enabled = true },
  --     statuscolumn = { enabled = true },
  --     words = { enabled = true },
  --   },
  -- },

  -- yazi
  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
  -- fzf-lua
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({})
    end,
  },
  -- undotree
  {
    "mbbill/undotree",
    keys = { { "<leader>tu", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" } },
  },
  -- ChatGPT
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   cmd = { "ChatGPTActAs", "ChatGPT" },
  --   opts = { api_key_cmd = "gpg --decrypt /Users/yang/gpg_key/openai_api_key.gpg" },
  -- },
  -- which-key: cheatsheet for pending keybinds
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      {
        mode = { "n", "v" },
        { "<leader>b", desc = "buffer" },
        { "<leader>c", desc = "code" },
        { "<leader>d", desc = "debug" },
        { "<leader>da", desc = "adapters" },
        { "<leader>f", desc = "find" },
        { "<leader>g", desc = "git" },
        { "<leader>gh", desc = "hunks" },
        { "<leader>gp", desc = "goto-preview" },
        { "<leader>o", desc = "other" },
        { "<leader>s", desc = "search" },
        { "<leader>t", desc = "toggle" },
        { "<leader>w", desc = "workspace" },
        { "<leader>x", desc = "diagnostics/quickfix" },
        { "[", desc = "prev" },
        { "]", desc = "next" },
        { "g", desc = "goto" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.add(opts)
    end,
  },

  -- harpoon: marks
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          "<leader><leader>",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<C-e>",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },

  -- fast buffer navigation
  {
    "leath-dub/snipe.nvim",
    keys = {
      {
        "<leader>bs",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu",
      },
    },
    opts = {},
  },

  -- navigator: navigate between neovim and multiplexers (tmux, kitty, wezterm)
  {
    "numToStr/Navigator.nvim",
    keys = {
      { "<C-h>", mode = { "n", "t" }, "<cmd>NavigatorLeft<cr>", desc = "Navi left" },
      { "<C-l>", mode = { "n", "t" }, "<cmd>NavigatorRight<cr>", desc = "Navi right" },
      { "<C-k>", mode = { "n", "t" }, "<cmd>NavigatorUp<cr>", desc = "Navi up" },
      { "<C-j>", mode = { "n", "t" }, "<cmd>NavigatorDown<cr>", desc = "Navi down" },
    },
    config = function()
      require("Navigator").setup({})
    end,
  },

  -- startup time
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime", -- lazy-load on command
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- colorizer
  {
    "norcalli/nvim-colorizer.lua",
    keys = { { "<leader>tC", "<cmd>ColorizerToggle<cr>", desc = "Toggle Colorizer" } },
    -- config = function()
    --   require("colorizer").setup()
    -- end,
  },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },
}

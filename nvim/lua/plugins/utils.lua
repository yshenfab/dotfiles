-- utils
return {
  -- undotree
  {
    "mbbill/undotree",
    keys = { { "<leader>tu", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" } },
  },
  -- ChatGPT
  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPTActAs", "ChatGPT" },
    opts = { api_key_cmd = "gpg --decrypt /Users/yang/gpg_key/openai_api_key.gpg" },
  },

  -- which-key: cheatsheet for pending keybinds
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        -- ["gz"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        -- ["<leader><tab>"] = { name = "+tabs" },
        -- ["<leader>a"] = { name = "+ai" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>d"] = { name = "+debug" },
        ["<leader>da"] = { name = "+adapters" },
        ["<leader>f"] = { name = "+find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>gp"] = { name = "+goto-preview" },
        ["<leader>o"] = { name = "+other" },
        -- ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>t"] = { name = "+toggle" },
        ["<leader>w"] = { name = "+workspace" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  -- harpoon: marks
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    keys = {
      "<leader>a",
      "<C-e>",
    },
    config = function()
      local nmap = function(tbl)
        vim.keymap.set("n", tbl[1], tbl[2], tbl[3])
      end

      local harpoon = require("harpoon")

      harpoon:setup()
      -- stylua: ignore
      nmap({ "<leader>a", function() harpoon:list():add() end })
      -- stylua: ignore
      nmap({ "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end })
    end,
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
    keys = { { "<leader>tc", "<cmd>ColorizerToggle<cr>", desc = "Toggle Colorizer" } },
    -- config = function()
    --   require("colorizer").setup()
    -- end,
  },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },
}

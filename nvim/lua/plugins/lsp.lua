return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        -- Fix clangd offset encoding
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", "/Users/yang/.markdownlint-cli2.yaml", "--" },
        },
      },
    },
  },

  -- cmp
  {
    "saghen/blink.cmp",
    dependencies = {
      "giuxtaposition/blink-cmp-copilot",
      "codeium.nvim",
      "saghen/blink.compat",
      "Kaiser-Yang/blink-cmp-avante",
    },
    ---@class PluginLspOpts
    opts = {
      signature = { enabled = true },
      keymap = {
        -- option 1: super-tab
        -- preset = "super-tab",
        -- option 2: tab to select next
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot", "avante" },
        compat = { "codeium" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            kind = "Copilot",
            score_offset = 100,
            async = true,
          },
          codeium = {
            kind = "Codeium",
            score_offset = 100,
            async = true,
          },
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            kind = "TabNine",
          },
        },
      },
    },
  },
}

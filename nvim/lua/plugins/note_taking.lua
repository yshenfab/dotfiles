-- note taking (markdown & org-mode)
return {
  -- markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = { "markdown" },
    keys = { { "<c-p>", "<cmd>MarkdownPreviewToggle<cr>", desc = "MarkdownPreview" } },
  },

  -- org-mode
  {
    "nvim-orgmode/orgmode",
    ft = "org",
    config = function()
      require("orgmode").setup_ts_grammar()

      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "org" },
        },
        ensure_installed = { "org" },
      })

      require("orgmode").setup({
        -- org_agenda_files = { "~/Dropbox/org/*", "~/my-orgs/**/*" },
        -- org_default_notes_file = "~/Dropbox/org/refile.org",
      })
    end,
  },

  -- neorg
  -- {
  --   "nvim-neorg/neorg",
  --   build = ":Neorg sync-parsers",
  --   ft = "norg",
  --   config = function()
  --     require("neorg").setup({
  --       load = {
  --         ["core.defaults"] = {}, -- Loads default behaviour
  --         ["core.concealer"] = {}, -- Adds pretty icons to your documents
  --         ["core.dirman"] = { -- Manages Neorg workspaces
  --           config = {
  --             workspaces = {
  --               notes = "~/OneDrive/notes/",
  --             },
  --           },
  --         },
  --       },
  --     })
  --   end,
  -- },
}

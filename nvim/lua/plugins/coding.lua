-- better coding & editing
return {
  -- tpope plugins
  "tpope/vim-sleuth", -- Heuristically set buffer options (shiftwidth, expandtab, tabstop, etc.)
  -- "tpope/vim-repeat", -- better dot-repeat

  -- snippets: my elves, they type so I don't have to
  {
    "L3MON4D3/LuaSnip",
    -- version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets", -- vscode style snippets
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },

  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua", -- Neovim Lua API
      "saadparwaiz1/cmp_luasnip", -- snippetes
      "onsails/lspkind.nvim", -- vscode-like icons for neovim built-in lsp
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local defaults = require("cmp.config.default")()
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback) -- <C-n>
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback) -- <C-p>
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        -- the order of the sources matter
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "nvim_lua" },
          -- AI powered autocompletion
          { name = "copilot" },
          { name = "cmp_tabnine", max_item_count = 3 },
          { name = "codeium", max_item_count = 3 },
          -- { name = "cmp_ai" },
          -- { name = "latex_symbols" }, -- latex symbols support
          -- { name = "orgmode" }, -- org-mode
        }),
        -- format
        formatting = {
          fields = { "kind", "abbr", "menu" },
          max_width = 50,
          format = require("lspkind").cmp_format({
            mode = "symbol", -- symbol_text
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[API]",
              path = "[Path]",
              luasnip = "[Snippet]",
              copilot = "[Copilot]",
              cmp_tabnine = "[TabNine]",
              codeium = "[Codeium]",
              -- cmp_ai = "[Cmp-ai]",
            },
            ellipsis_char = "...",
            symbol_map = { Copilot = "", TabNine = "󰚩", Codeium = "" },
          }),
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
  },

  -- auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        map_cr = false,
      })
    end,
  },

  -- surround: add/delete/change surroundings
  -- add: ys{motion}{char}, delete: ds{char}, change: cs{target}{replacement}
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- comments
  -- normal mode: gcc/gbc, visual mode: gc/gb
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  -- todo-comments: Highlight, list and search todo comments like TODO, FIXME, HACK, BUG, NOTE, FIX, WARNING, etc.
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },

  -- code runner
  {
    "michaelb/sniprun",
    keys = {
      { "<leader>cR", mode = { "n", "o" }, "<cmd>SnipRun<cr>", desc = "Code Runner" },
      { "<leader>cR", mode = { "x", "o" }, "<cmd>'<,'>SnipRun<cr>", desc = "Code Runner" },
    },
  },

  -- outline: tree-like outline of symbols
  -- {
  --   "hedyhli/outline.nvim",
  --   keys = { { "<leader>to", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
  --   cmd = "Outline",
  --   config = function()
  --     require("outline").setup({})
  --   end,
  -- },

  -- aerial: code outline
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    opts = {},
    keys = { { "<leader>ta", "<cmd>AerialToggle<cr>", desc = "Toggle Aerial" } },
  },

  -- motions: flash
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc =
        "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
  },

  -- illuminate: auto highlight word under the cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },

  -- multi cursor
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    keys = {
      { "<c-n>", mode = "n", desc = "multi cursor" },
    },
  },

  -- neogen: annotation generator
  {
    "danymat/neogen",
    -- stylua: ignore
    keys = {
      { "<leader>cC", function() require("neogen").generate({}) end, desc = "Neogen Comment", },
    },
    opts = { snippet_engine = "luasnip" },
  },

  -- delete buffer
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer", },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)", },
    },
  },
  -- better text objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup({})
    end,
  },
}

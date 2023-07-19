-- Telescope: Fuzzy Finder (files, lsp, etc)
return {
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    cmd = "Telescope",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      { "AckslD/nvim-neoclip.lua",                  dependencies = { "kkharji/sqlite.lua", module = "sqlite" } },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
      })
      -- load extensions
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("neoclip")

      local function nmap(lhs, rhs, opts)
        opts = opts or {}
        opts.silent = opts.silent ~= false
        vim.keymap.set("n", lhs, rhs, opts)
      end

      local tele = require("telescope.builtin")

      -- fuzzy search in current buffer
      nmap("<leader>/", function()
        tele.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[/] Fuzzy search in current buffer" })
      -- find (MRU, files, buffers, etc.)
      nmap("<leader>fo", tele.oldfiles, { desc = "Oldfiles (MRU)" })
      nmap("<leader>ff", tele.find_files, { desc = "Files" })
      nmap("<leader>fb", tele.buffers, { desc = "Buffers" })
      nmap("<leader>fw", tele.grep_string, { desc = "Word" })
      nmap("<leader>fg", tele.live_grep, { desc = "Live Grep (rg)" })
      nmap("<leader>fm", "<cmd>Telescope file_browser<cr>", { desc = "File Browser" })
      nmap(
        "<leader>fM",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
        { desc = "File Browser (current buffer)" }
      )
      nmap("<leader>fy", "<cmd>Telescope neoclip<cr>", { desc = "Clipboard Manager" })
      -- git
      nmap("<leader>gf", tele.git_files, { desc = "Git Files" })
      nmap("<space>gs", tele.git_status, { desc = "Git Status" })
      nmap("<space>gc", tele.git_commits, { desc = "Git Commit" })
      -- search
      nmap("<leader>sa", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands" })
      nmap("<leader>sc", tele.command_history, { desc = "Command History" })
      nmap("<leader>ss", tele.search_history, { desc = "Search History" })
      nmap("<leader>sS", tele.treesitter, { desc = "Treesitter Symbols" })
      nmap("<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document Diagnostics" })
      nmap("<leader>sD", tele.diagnostics, { desc = "Workspace Diagnostics" })
      nmap("<leader>sh", tele.help_tags, { desc = "Help Pages" })
      -- other
      nmap("<leader>oo", tele.vim_options, { desc = "Vim Options" })
      nmap("<leader>ok", tele.keymaps, { desc = "Keymaps" })
    end,
  },
}

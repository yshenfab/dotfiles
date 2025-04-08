-- Highlight, edit, and navigate code
return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  cmd = { "TSUpdateSync" },
  keys = {
    { "<c-z>", desc = "Increment selection" },
    { "<bs>", desc = "Decrement selection", mode = "x" },
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "cuda",
        "dockerfile",
        "python",
        "lua",
        "json",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "html",
        "query",
        "regex",
        "yaml",
      },
      sync_install = false,
      auto_install = true,

      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-z>",
          node_incremental = "<c-z>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>sp"] = "@parameter.inner",
            ["<leader>sf"] = "@function.outer",
          },
          swap_previous = {
            ["<leader>sP"] = "@parameter.inner",
            ["<leader>sF"] = "@function.outer",
          },
        },
      },
    })
  end,
}

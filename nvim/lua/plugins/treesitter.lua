-- Highlight, edit, and navigate code
return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    init = function()
      -- disable rtp plugin
      require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
      load_textobjects = true
    end,
  },
  cmd = { "TSUpdateSync" },
  keys = {
    { "<c-z>", desc = "Increment selection" },
    { "<c-x>", desc = "Decrement selection", mode = "x" },
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "cmake",
        "cuda",
        "dockerfile",
        "python",
        "go",
        "lua",
        "javascript",
        "json",
        "typescript",
        "vimdoc",
        "vim",
        "latex",
        "bibtex",
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
      indent = { enable = true }, -- indent = { enable = true, disable = { "python" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-z>",
          node_incremental = "<c-z>",
          scope_incremental = false,
          node_decremental = "<c-x>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
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
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>sp"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>sP"] = "@parameter.inner",
          },
        },
      },
    })
  end,
}

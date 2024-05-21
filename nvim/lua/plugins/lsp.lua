-- LSP Plugins
-- https://langserver.org/
-- https://microsoft.github.io/language-server-protocol/implementers/servers/
return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} }, -- additional lua configuration, makes nvim stuff amazing!
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- vscode-like icons for neovim built-in lsp
      "onsails/lspkind.nvim",
    },
    config = function()
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        local imap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("i", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<c-s>", vim.lsp.buf.signature_help, "Signature Help")
        imap("<c-s>", vim.lsp.buf.signature_help, "Signature Help")

        nmap("<leader>cr", vim.lsp.buf.rename, "Code Rename")
        nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

        nmap("gd", vim.lsp.buf.definition, "Goto Definition")
        nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
        nmap("gT", vim.lsp.buf.type_definition, "Goto Type Definition")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")

        nmap("gr", require("telescope.builtin").lsp_references, "Goto References")
        nmap("gI", vim.lsp.buf.implementation, "Goto Implementation")
        nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
        nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_worspace_symbols, "Workspace Symbols")

        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
        nmap("<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "Workspace List Folders")
      end

      local servers = {
        bashls = {},
        clangd = {},
        ruff_lsp = {},
        pyright = {},
      }

      -- mason-lspconfig
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          })
        end,
      })

      -- fix clangd offset encoding
      require("lspconfig").clangd.setup({
        on_attach = on_attach,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        cmd = { "clangd", "--offset-encoding=utf-16" },
      })

      -- lspkind
      require("lspkind").init({
        mode = "symbol",
        preset = "codicons", -- require vscode-codicons font
        symbol_map = { Copilot = "", TabNine = "󰚩", Codeium = "" },
      })
    end,
  },

  -- goto-preview: preview native LSP's goto definition, type definition, implementation, and references calls in floating windows
  {
    "rmagatti/goto-preview",
    keys = {
      { "gpd", mode = "n", desc = "preview definition" },
      { "gpt", mode = "n", desc = "preview type definition" },
      { "gpi", mode = "n", desc = "preview implementation" },
      { "gpr", mode = "n", desc = "preview references" },
      { "gP", mode = "n", desc = "close all preview windows" },
    },
    config = function()
      require("goto-preview").setup({
        default_mappings = true,
      })
    end,
  },

  -- mason: automatically install LSPs to stdpath for neovim
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- conform (formatting)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Code Format",
      },
    },
    opts = {
      formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
        python = { "isort", "ruff_format" }, -- { "black" },
        markdown = { "prettierd" }, -- also for javascript, typescript, json, yaml, etc.
        sh = { "shfmt" },
        lua = { "stylua" },
        ["*"] = { "codespell" }, -- "*": all filetypes.
        ["_"] = { "trim_whitespace" }, -- "_": filetypes that don't have other formatters configured.
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  -- nvim-lint (linting)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        c = { "cpplint" },
        cpp = { "cpplint" },
        python = { "ruff" }, -- { "pylint" },
        markdown = { "markdownlint" },
        -- lua = { "selene", "luacheck" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- lspsaga: beautify the Neovim built-in LSP UI
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach", -- lazy load
    config = function()
      require("lspsaga").setup()
    end,
  },
}

-- LSP Plugins
-- https://langserver.org/
-- https://microsoft.github.io/language-server-protocol/implementors/servers/
return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim",  opts = {} }, -- additional lua configuration, makes nvim stuff amazing!
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

      -- mason-lspconfig
      local mason_lspconfig = require("mason-lspconfig")
      local servers = {
        bashls = {},
        clangd = {},
        dockerls = {},
        ruff_lsp = {},
        pyright = {},
        gopls = {},
        tsserver = {},
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }
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
      { "gP",  mode = "n", desc = "close all preview windows" },
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

  -- null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("null-ls").setup({
        sources = {
          -- code actions
          require("null-ls").builtins.code_actions.gitsigns,
          -- completion
          require("null-ls").builtins.completion.spell,
          -- diagnostics
          require("null-ls").builtins.diagnostics.clang_check, -- llvm project
          require("null-ls").builtins.diagnostics.cppcheck,    -- static analysis
          require("null-ls").builtins.diagnostics.cpplint,     -- Google C++ style guide
          require("null-ls").builtins.diagnostics.flake8,      -- or use ruff
          -- require("null-ls").builtins.diagnostics.eslint,
          -- require("null-ls").builtins.diagnostics.selene,
          require("null-ls").builtins.diagnostics.markdownlint,
          require("null-ls").builtins.diagnostics.chktex,
          -- formatting
          require("null-ls").builtins.formatting.clang_format,
          require("null-ls").builtins.formatting.ruff,
          require("null-ls").builtins.formatting.black,
          -- require("null-ls").builtins.formatting.autoflake,
          require("null-ls").builtins.formatting.isort,
          require("null-ls").builtins.formatting.shfmt,
          require("null-ls").builtins.formatting.prettierd,
          require("null-ls").builtins.formatting.stylua,
          require("null-ls").builtins.formatting.gofmt,
          require("null-ls").builtins.formatting.latexindent,
          require("null-ls").builtins.formatting.markdownlint,
          require("null-ls").builtins.formatting.markdown_toc,
          require("null-ls").builtins.formatting.trim_whitespace,
        },
      })
    end,
  },

  -- mason-null-ls
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-null-ls").setup({
        automatic_setup = true,
      })
    end,
  },

  -- lspsaga: beautify the Neovim built-in LSP UI
  -- {
  --   "nvimdev/lspsaga.nvim",
  --   event = "LspAttach", -- lazy load
  --   config = function()
  --     require("lspsaga").setup()
  --   end,
  -- },
}

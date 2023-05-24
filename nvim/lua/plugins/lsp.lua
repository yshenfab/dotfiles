-- LSP Plugins
-- https://langserver.org/
-- https://microsoft.github.io/language-server-protocol/implementors/servers/
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			-- Useful status updates for LSP
			{ "j-hui/fidget.nvim",       opts = {} },
			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
			-- preview native LSP's goto definition, type definition, implementation,
			-- and references calls in floating windows
			"rmagatti/goto-preview",
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

				nmap("<c-s>", vim.lsp.buf.signature_help, "[S]ignature Help")
				imap("<c-s>", vim.lsp.buf.signature_help, "[S]ignature Help")

				nmap("<leader>cr", vim.lsp.buf.rename, "[R]ename")
				nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

				nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				nmap("gT", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")

				nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_worspace_symbols, "[W]orkspace [S]ymbols")

				nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
				nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				nmap("<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[W]orkspace [L]ist Folders")
			end

			-- neodev: setup neovim lua configuration
			require("neodev").setup()

			-- Mason
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			-- Mason-lspconfig
			local mason_lspconfig = require("mason-lspconfig")
			-- install servers
			local servers = {
				clangd = {},
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
			-- goto-preview
			require("goto-preview").setup({
				default_mappings = true,
				-- gpd: goto preview definition
				-- gpt: goto preview type definition
				-- gpi: goto preview implementation
				-- gpr: goto preview references
				-- gP: close all preview windows
			})
			-- lspkind
			require("lspkind").init({
				mode = "symbol_text",
				preset = "codicons", -- require vscode-codicons font
				symbol_map = {
					Copilot = "",
				},
			})
		end,
	},
	-- null-ls
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("null-ls").setup({
				sources = {
					-- code actions
					require("null-ls").builtins.code_actions.gitsigns,
					-- completion
					require("null-ls").builtins.completion.spell,
					-- diagnostics
					require("null-ls").builtins.diagnostics.clang_check, -- llvm project
					require("null-ls").builtins.diagnostics.cppcheck, -- static analysis
					require("null-ls").builtins.diagnostics.cpplint, -- Google C++ style guide
					require("null-ls").builtins.diagnostics.flake8,
					-- require("null-ls").builtins.diagnostics.eslint,
					-- require("null-ls").builtins.diagnostics.selene,
					require("null-ls").builtins.diagnostics.markdownlint,
					require("null-ls").builtins.diagnostics.chktex,
					-- formatting
					require("null-ls").builtins.formatting.clang_format,
					require("null-ls").builtins.formatting.black,
					require("null-ls").builtins.formatting.isort,
					require("null-ls").builtins.formatting.shfmt,
					require("null-ls").builtins.formatting.prettierd,
					require("null-ls").builtins.formatting.stylua,
					require("null-ls").builtins.formatting.google_java_format,
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
}

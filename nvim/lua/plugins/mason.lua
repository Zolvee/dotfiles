-- /mason.lua --

return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},

		config = function()
			local lspconfig = require("lspconfig")

			-- Optional nvim-cmp capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok, cmp_cap = pcall(require, "cmp_nvim_lsp")
			if ok then
				capabilities = cmp_cap.default_capabilities(capabilities)
			end

			-- Mason ensure_installed uses Mason's internal names
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls",
					"pyright",
					"clangd",
					"lua_ls",
					"html",
					"cssls",
					"jsonls",
					"yamlls",
					"tailwindcss",
				},
				automatic_installation = false,
			})

			-- Optional keymap setup
			local function on_attach(_, bufnr)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end
				-- Add keymaps here if needed
			end

			-- TailwindCSS override (disable default setup)
			local configs = require("lspconfig.configs")
			if configs.tailwindcss then
				configs.tailwindcss = nil
			end

			-- Define custom config per server
			local custom_configs = {
				ts_ls = {
					on_attach = on_attach,
					capabilities = capabilities,
					handlers = {
						["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
							if result.diagnostics then
								local filtered = {}
								for _, diagnostic in ipairs(result.diagnostics) do
									local code = diagnostic.code
									if code ~= 6133 and code ~= 6196 then
										table.insert(filtered, diagnostic)
									end
								end
								result.diagnostics = filtered
							end
							vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
						end,
					},
				},

				lua_ls = {
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
								path = vim.split(package.path or "", ";"),
							},
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
							telemetry = { enable = false },
						},
					},
				},
				tailwindcss = {
					on_attach = on_attach,
					capabilities = capabilities,
					filetypes = {
						"html",
						"css",
						"scss",
						"sass",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"svelte",
						"astro",
						"mdx",
					},
					-- Important: we force the root to be the monorepo root (not apps/web)
					root_dir = require("lspconfig").util.root_pattern("pnpm-workspace.yaml", "package.json", ".git"),

					settings = {
						tailwindCSS = {
							classAttributes = { "class", "className", "class:list", "ngClass" },
							emmetCompletions = true,
							experimental = {
								configFile = vim.fn.expand("packages/ui/src/styles/globals.css"), -- ✅ manually point to Tailwind v4 config
								classRegex = {
									{ "clsx\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
									{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
									{ "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
									{ "tw`([^`]*)`", "([^`]*)" },
									{ "class:\\s*`([^`]*)`", "([^`]*)" },
								},
							},
							includeLanguages = {
								eelixir = "html-eex",
								eruby = "erb",
								htmlangular = "html",
								templ = "html",
							},
							lint = {
								cssConflict = "warning",
								invalidApply = "error",
								invalidConfigPath = "error",
								invalidScreen = "error",
								invalidTailwindDirective = "error",
								invalidVariant = "error",
								recommendedVariantOrder = "warning",
							},
							validate = true,
						},
					},
				},
			}

			-- Default config for other servers
			local default_config = {
				on_attach = on_attach,
				capabilities = capabilities,
			}

			-- Setup loop for all installed servers

			local mason_lspconfig = require("mason-lspconfig")
			for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
				local config = vim.tbl_deep_extend("force", {}, default_config, custom_configs[server_name] or {})
				lspconfig[server_name].setup(config)
			end
		end,
	},
}

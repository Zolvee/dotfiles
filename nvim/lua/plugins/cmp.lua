-- /lua/plugins/cmp.lua --

return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
			"tzachar/cmp-fuzzy-buffer",
			"tzachar/cmp-fuzzy-path",
			{ "tzachar/fuzzy.nvim", build = "make" },
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),

				window = {
					completion = cmp.config.window.bordered({
						max_height = 8,
						scrollbar = true,
						winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSelection,Search:None",
					}),
					documentation = cmp.config.window.bordered({
						winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder",
					}),
				},

				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},

				experimental = {
					ghost_text = true,
				},

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "fuzzy_buffer" },
					{ name = "fuzzy_path" },
				}),
			})

			-- CRT-style highlight groups
			vim.api.nvim_set_hl(0, "CmpNormal", { fg = "#00FF00", bg = "#000000" })
			vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#00AA00", bg = "#000000" })
			vim.api.nvim_set_hl(0, "CmpSelection", { fg = "#000000", bg = "#00FF00", bold = true })
			vim.api.nvim_set_hl(0, "CmpDocNormal", { fg = "#00FF00", bg = "#001100" })
			vim.api.nvim_set_hl(0, "CmpDocBorder", { fg = "#00AA00", bg = "#001100" })
		end,
	},
}

-- /formatting.lua --

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			javascript = { "eslint_d", "prettier" },
			typescript = { "eslint_d", "prettier" },
			javascriptreact = { "eslint_d", "prettier" },
			typescriptreact = { "eslint_d", "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			lua = { "stylua" },
			astro = { "prettier" },
		},
		format_on_save = {
			timeout_ms = 2000,
			lsp_fallback = true,
		},
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)

		-- Single binding to format the entire file
		vim.keymap.set("n", "<leader>=", function()
			conform.format({ bufnr = 0 })
		end, { desc = "Format entire file" })
	end,
}

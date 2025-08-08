-- /diagnostics.lua --

-- Configure diagnostic display
vim.diagnostic.config({
	virtual_text = false, -- no inline diagnostic text
	underline = true, -- underline errors/warnings
	signs = true, -- show signs in gutter
	severity_sort = true, -- sort by severity
	float = {
		border = "rounded",
		source = "if_many",
	},
})

-- Define diagnostic signs (gutter icons)
--
local signs = { Error = "×", Warn = "!", Hint = "", Info = "ℹ" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Diagnostic navigation keymaps
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next({ float = true })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev({ float = true })
end, { desc = "Prev diagnostic" })

-- Show all buffer diagnostics in a floating preview window
vim.keymap.set("n", "<leader>xx", function()
	local diagnostics = vim.diagnostic.get(0)
	if vim.tbl_isempty(diagnostics) then
		print("No diagnostics")
		return
	end

	local lines = {}
	for _, d in ipairs(diagnostics) do
		local severity = vim.diagnostic.severity[d.severity] or "Unknown"
		local msg = string.format("%d:%d [%s] %s", d.lnum + 1, d.col + 1, severity, d.message)
		table.insert(lines, msg)
	end

	vim.lsp.util.open_floating_preview(lines, "plaintext", {
		border = "rounded",
		title = "Diagnostics",
		max_width = 80,
		wrap = true,
	})
end, { desc = "Show all buffer diagnostics" })

-- Highlight style (undercurl for underline)
vim.cmd([[
  highlight DiagnosticUnderlineError gui=undercurl guisp=Red
  highlight DiagnosticUnderlineWarn gui=undercurl guisp=Orange
  highlight DiagnosticUnderlineInfo gui=undercurl guisp=LightBlue
  highlight DiagnosticUnderlineHint gui=undercurl guisp=LightGrey
]])

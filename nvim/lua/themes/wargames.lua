local M = {}

function M.setup()
	vim.g.colors_name = "wargames"

	local palette = {
		bg = "#000000",
		fg = "#00FF00",
		dim_fg = "#00AA00",
		accent = "#00CC00",
		red = "#FF5555",
		yellow = "#FFFF55",
		blue = "#00FFFF",
		cyan = "#00DDDD",
		white = "#CCCCCC",
		comment = "#007700",
		dark = "#003300",
		light_red = "#FF7777",
		method = "#FFAA33",
	}

	local function link_all(target, ...)
		for i = 1, select("#", ...) do
			vim.api.nvim_set_hl(0, select(i, ...), { link = target })
		end
	end

	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	vim.o.termguicolors = true

	local set = vim.api.nvim_set_hl

	-- UI
	set(0, "Normal", { fg = palette.fg, bg = palette.bg })
	set(0, "StatusLine", { fg = palette.fg, bg = palette.dark, bold = true })
	set(0, "StatusLineNC", { fg = palette.dim_fg, bg = "#001100" })
	set(0, "VertSplit", { fg = palette.dim_fg, bg = palette.bg })
	set(0, "TabLine", { fg = palette.dim_fg, bg = palette.bg })
	set(0, "TabLineSel", { fg = palette.bg, bg = palette.fg, bold = true })
	set(0, "TabLineFill", { fg = palette.dim_fg, bg = palette.bg })
	set(0, "Visual", { bg = palette.dark })
	set(0, "CursorLine", { bg = "#001100" })
	set(0, "CursorColumn", { bg = "#001100" })
	set(0, "LineNr", { fg = palette.comment })
	set(0, "CursorLineNr", { fg = palette.yellow, bold = true })

	-- Base syntax
	set(0, "Comment", { fg = palette.comment, italic = true })
	set(0, "String", { fg = palette.accent })
	set(0, "Function", { fg = palette.fg })
	set(0, "Identifier", { fg = palette.fg })
	set(0, "Statement", { fg = palette.fg })
	set(0, "Keyword", { fg = palette.fg })
	set(0, "Type", { fg = palette.fg })
	set(0, "Number", { fg = palette.blue })
	set(0, "Error", { fg = palette.bg, bg = palette.red, bold = true })
	set(0, "Todo", { fg = palette.yellow, bold = true })

	-- Treesitter
	set(0, "@keyword", { fg = palette.accent, bold = true })
	set(0, "@keyword.return", { fg = "#FFFF88", bold = true })
	set(0, "@keyword.import.tsx", { fg = "#FF4444", bold = true })
	set(0, "@keyword.import.typescript", { fg = "#FF4444", bold = true })
	set(0, "@keyword.tsx", { link = "@keyword.coroutine" })
	set(0, "@keyword.typescript", { fg = "#FFBB88", bold = true })
	set(0, "@function", { fg = palette.fg })
	set(0, "@function.call", { fg = palette.blue, bold = true })
	set(0, "@function.method", { fg = palette.method, bold = true })
	set(0, "@function.method.call", { fg = palette.blue, bold = true })
	set(0, "@type", { fg = "#66FFFF", italic = true })
	set(0, "@type.builtin", { fg = palette.yellow })
	set(0, "@string", { fg = palette.accent })
	set(0, "@variable", { fg = palette.white })
	set(0, "@variable.parameter", { fg = palette.yellow, italic = true })
	set(0, "@parameter", { fg = palette.yellow, italic = true })
	set(0, "@number", { fg = palette.blue })
	set(0, "@boolean", { fg = palette.red, bold = true })
	set(0, "@operator", { fg = palette.fg })
	set(0, "@property", { fg = palette.cyan })
	set(0, "@import", { fg = "#88FFFF", bold = true }) -- light cyan
	set(0, "@field", { fg = palette.dim_fg })
	set(0, "@comment", { fg = palette.comment, italic = true })
	set(0, "@tag", { fg = palette.yellow })
	set(0, "@tag.attribute", { fg = palette.yellow })
	set(0, "@tag.attribute.tsx", { fg = palette.yellow })
	set(0, "@attribute", { fg = palette.blue, italic = true })
	set(0, "@punctuation.delimiter", { fg = palette.dim_fg })
	set(0, "@punctuation.bracket", { fg = palette.fg })
	set(0, "@keyword.modifier.typescript", { fg = palette.light_red, bold = true })
	set(0, "@variable.member.typescript", { fg = palette.dim_fg })
	set(0, "@variable.member.typescript", { fg = palette.dim_fg })
	set(0, "@keyword.coroutine", { fg = "#FF8888", bold = true })
	set(0, "@keyword.await", { fg = "#88AAFF", bold = true })
	set(0, "@keyword.export", { fg = "#FFAA88", bold = true })
	set(0, "@keyword.default", { fg = "#FFBB88", bold = true })

	-- LSP Semantic Tokens
	set(0, "@lsp.type.class.typescript", { fg = palette.yellow, bold = true })
	set(0, "@lsp.type.interface.typescript", { fg = "#FFFFAA", italic = true })
	set(0, "@lsp.type.enum.typescript", { fg = "#FFCC66", bold = true })
	set(0, "@lsp.type.typeParameter.typescript", { fg = "#99FFCC", italic = true })
	set(0, "@lsp.type.parameter.typescript", { fg = palette.yellow, italic = true })
	set(0, "@lsp.type.property.typescript", { fg = palette.cyan })
	set(0, "@lsp.type.variable.typescript", { fg = palette.white })
	set(0, "@lsp.type.function.typescript", { fg = palette.fg })
	set(0, "@lsp.typemod.member.declaration.typescript", { fg = palette.dim_fg })
	set(0, "@lsp.typemod.parameter.declaration.typescript", { fg = palette.white })
	set(0, "@lsp.mod.declaration.typescript", { fg = palette.accent, italic = true })
	set(0, "@lsp.type.parameter.typescript", { fg = palette.yellow, italic = true })

	-- Telescope
	set(0, "TelescopeBorder", { fg = palette.dim_fg, bg = palette.bg })
	set(0, "TelescopePromptBorder", { fg = palette.accent, bg = palette.bg })
	set(0, "TelescopePromptTitle", { fg = palette.bg, bg = palette.accent, bold = true })
	set(0, "TelescopePromptNormal", { fg = palette.fg, bg = palette.bg })
	set(0, "TelescopeResultsTitle", { fg = palette.bg, bg = palette.comment, bold = true })
	set(0, "TelescopeResultsNormal", { fg = palette.fg, bg = palette.bg })
	set(0, "TelescopePreviewTitle", { fg = palette.bg, bg = palette.blue, bold = true })
	set(0, "TelescopePreviewNormal", { fg = palette.fg, bg = palette.bg })
	set(0, "TelescopeSelection", { fg = palette.fg, bg = palette.dark, bold = true })
	set(0, "TelescopeMatching", { fg = palette.yellow, bold = true })

	-- Completion menu
	set(0, "CmpNormal", { fg = palette.fg, bg = palette.bg })
	set(0, "CmpSelection", { fg = palette.bg, bg = palette.accent, bold = true })
	set(0, "CmpBorder", { fg = palette.dim_fg, bg = palette.bg })

	-- Documentation popup
	set(0, "CmpDocNormal", { fg = palette.fg, bg = "#001100" })
	set(0, "CmpDocBorder", { fg = palette.dim_fg, bg = "#001100" })

	-- Diagnostics (no virtual text; undercurl + sign column only)
	local diag_colors = {
		Error = palette.red,
		Warn = palette.yellow,
		Info = palette.blue,
		Hint = "#88CCFF",
	}

	for type, color in pairs(diag_colors) do
		local hl_sign = "DiagnosticSign" .. type
		local hl_line = "DiagnosticUnderline" .. type
		local hl_text = "Diagnostic" .. type

		set(0, hl_sign, { fg = color, bg = palette.bg })
		set(0, hl_line, { sp = color, undercurl = true })
		set(0, hl_text, { fg = color })
	end

	-- LSP semantic token links
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function()
			link_all(
				"@function.call",
				"@lsp.type.function",
				"@lsp.type.function.typescriptreact",
				"@lsp.typemod.function",
				"@lsp.typemod.function.readonly",
				"@lsp.typemod.function.readonly.typescriptreact",
				"@lsp.typemod.function.defaultLibrary",
				"@lsp.typemod.function.defaultLibrary.typescriptreact"
			)

			link_all(
				"@variable",
				"@lsp.type.variable",
				"@lsp.type.variable.typescriptreact",
				"@lsp.typemod.variable",
				"@lsp.typemod.variable.readonly",
				"@lsp.typemod.variable.readonly.typescriptreact"
			)

			link_all("@keyword.default", "@lsp.type.keyword.default")
			link_all("@keyword.coroutine", "@lsp.type.keyword.coroutine")
			link_all("@keyword.await", "@lsp.type.keyword.await")

			link_all("@property", "@lsp.type.property.typescript", "@lsp.typemod.property.declaration.typescript")
			link_all("@function.method", "@lsp.type.member.typescript", "@lsp.typemod.member.declaration.typescript")
		end,
	})
end

return M

return {
	"unblevable/quick-scope",
	config = function()
		-- Highlight only on f, F, t, T taps (optional; see README)
		vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
	end,
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "neo-tree", "lazy", "TelescopePrompt" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "diff" },
				lualine_c = {
					"location",
					{ "filename", path = 0 },
				},
				lualine_x = { "filetype" },
				lualine_y = { "progress", "branch" },
				lualine_z = {
					function()
						return os.date("%H:%M")
					end,
				},
			},
		})
	end,
}

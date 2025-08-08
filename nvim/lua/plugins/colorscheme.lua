return {
	{
		name = "wargames",
		dir = vim.fn.stdpath("config") .. "/lua/themes", -- point to your local folder
		lazy = false,
		priority = 1000,
		config = function()
			require("themes.wargames").setup()
		end,
	},
}

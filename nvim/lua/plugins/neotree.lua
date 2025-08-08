-- /neotree.lua --

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			enable_git_status = true,
			filesystem = {
				follow_current_file = {
					enabled = true,
				},
				hijack_netrw_behavior = "open_default",
			},
			source_selector = {
				winbar = true,
				content_layout = "center",
			},
		})

		-- Keybindings
		vim.keymap.set("n", "<leader>tt", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
		vim.keymap.set("n", "<leader>tf", "<cmd>Neotree focus<CR>", { desc = "Focus Neo-tree" })
		vim.keymap.set("n", "<leader>tc", "<cmd>Neotree collapse<CR>", { desc = "Collapse Neo-tree" })
		vim.keymap.set("n", "<leader>tb", "<cmd>Neotree toggle buffers<CR>", { desc = "Toggle Neo-tree Buffers" })
		vim.keymap.set("n", "<leader>tg", "<cmd>Neotree toggle git_status<CR>", { desc = "Neo-tree Git Status" })
	end,
}

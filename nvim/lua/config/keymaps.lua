-- /keymaps.lua --

-- General QA
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Write/save file" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Resize splits with arrow keys
vim.keymap.set("n", "<A-Up>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<A-Down>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<CR>")

-- Buffer and tab management
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "[B]uffer [D]elete" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Conform format
vim.api.nvim_create_user_command("Format", function(args)
	require("conform").format({
		lsp_fallback = true,
		async = args.bang,
	})
end, {
	desc = "Format buffer with conform.nvim",
	bang = true,
})

-- Diagnostics
vim.keymap.set("n", "<leader>e", function()
	vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Show diagnostics in float" })

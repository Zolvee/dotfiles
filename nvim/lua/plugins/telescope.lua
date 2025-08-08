return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = { preview_width = 0.6 },
					preview_cutoff = 10,
					prompt_position = "top",
				},
				sorting_strategy = "ascending",
				mappings = {
					i = {
						["<esc>"] = actions.close,
					},
				},
				find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
				file_ignore_patterns = {
					"node_modules/",
					"build/",
					"dist/",
					"yarn.lock",
					"package%-lock%.json",
					"%.git/",
					"%.cache/",
					"%.next/",
					"%.turbo/",
					"%.vscode/",
					"__pycache__/",
					"%.jpg",
					"%.jpeg",
					"%.png",
					"%.svg",
					"%.webp",
					"%.ico",
					"%.ttf",
					"%.woff",
					"%.otf",
					"%.mp4",
					"%.mp3",
					"%.mov",
					"%.avi",
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		pcall(telescope.load_extension, "ui-select")
		pcall(telescope.load_extension, "fzf")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
		vim.keymap.set("n", "<leader> ", builtin.buffers, { desc = "[F]ind [B]uffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "[F]ind [O]ld Files" })
		vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "Go to definition" })
		vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, { desc = "Find Implementations" })

		vim.keymap.set("n", "gF", function()
			local word = vim.fn.expand("<cword>")
			vim.cmd("vsplit")
			require("telescope.builtin").find_files({
				default_text = word,
			})
		end, { desc = "Telescope file jump in split" })

		vim.keymap.set("n", "<leader>fs", function()
			require("telescope.builtin").grep_string({
				search = vim.fn.expand("<cword>"),
			})
		end, { desc = "[F]ind [S]ymbol under cursor" })
	end,
}

return {
	"nvim-telescope/telescope.nvim",
	commit = "a4432dfb9b0b960c4cbc8765a42dc4fe2e029e8f",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				file_ignore_patterns = { "node_modules", "/.git", "proto/gen", "mocks", "c7bc9c66", "mini.*%.js" },
				path_display = { "filename_first" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				lsp_document_symbols = {
					symbol_width = 75,
				},
			},
			extensions = {
				fzf = {},
			},
			-- pickers = {
			-- 	theme = "ivy",
			-- 	find_files = {
			-- 		theme = "ivy",
			-- 	},
			-- 	lsp_references = {
			-- 		theme = "ivy",
			-- 	},
			-- 	lsp_document_symbols = {
			-- 		symbol_width = 75,
			-- 		theme = "ivy",
			-- 	},
			-- 	lsp_incoming_calls = {
			-- 		theme = "ivy",
			-- 	},
			-- 	live_grep = {
			-- 		theme = "ivy",
			-- 	},
			-- 	grep_string = {
			-- 		theme = "ivy",
			-- 	},
			-- },
		})

		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "List all references" })
		keymap.set("n", "<leader>fg", function()
			require("telescope.builtin").live_grep({
				glob_pattern = { "!*_test.go" },
				type_filter = "go",
				desc = "Find string in go files",
			})
		end, { noremap = true, silent = true })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope lsp_incoming_calls<cr>", { desc = "List all incoming calls" })
		keymap.set("n", "<leader>fp", "<cmd>Telescope find_files<cr>", { desc = "List all incoming calls" })
		keymap.set("n", "<leader>fw", function()
			require("telescope.builtin").lsp_document_symbols({
				desc = "List all documents symbols",
				fname_width = 200,
			})
		end)
		keymap.set("n", "<leader>fp", function()
			require("telescope.builtin").find_files({
				search_dirs = { vim.loop.cwd() },
				find_command = { "find", ".", "-type", "f", "-name", "*.proto" },
			})
		end, { noremap = true, silent = true })
		keymap.set("n", "<leader>f;", function()
			require("telescope.builtin").find_files({
				search_dirs = { "~/projects/proto/" },
				find_command = { "find", ".", "-type", "f", "-name", "*.proto" },
			})
		end, { noremap = true, silent = true })
		keymap.set("n", "<leader>f:", function()
			require("telescope.builtin").find_files({
				search_dirs = { "~/projects/atlas/" },
				find_command = { "find", ".", "-type", "f", "-name", "*.proto" },
			})
		end, { noremap = true, silent = true })
		keymap.set("n", "<leader>fv", function()
			require("telescope.builtin").find_files({
				search_dirs = { "/Users/kiliandemeulemeester/Library/Mobile Documents/iCloud~md~obsidian/" },
				find_command = { "find", ".", "-type", "f", "-name", "*.md" },
				desc = { "Open vault file" },
			})
		end, { noremap = true, silent = true })

		keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help tags" })

		keymap.set("n", "<leader>en", function()
			require("telescope.builtin").find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end, { noremap = true, silent = true })
	end,
}

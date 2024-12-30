return {
    "nvim-telescope/telescope.nvim",
    commit = "a4432dfb9b0b960c4cbc8765a42dc4fe2e029e8f",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
        { "nvim-telescope/telescope-fzf-native.nvim",     build = "make" },
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
                        ["<C-j>"] = actions.move_selection_next,     -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
            pickers = {
                theme = "ivy",
                find_files = {
                    theme = "ivy",
                },
                lsp_references = {
                    theme = "ivy",
                },
                lsp_incoming_calls = {
                    theme = "ivy",
                },
                live_grep = {
                    theme = "ivy",
                },
                grep_string = {
                    theme = "ivy",
                },
                lsp_document_symbols = {
                    symbol_width = 75,
                    theme = "ivy",
                },
            },
            extensions = {
                fzf = {},
            },
        })

        telescope.load_extension("fzf")
        telescope.load_extension("live_grep_args")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })

        keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "List all references" })

        keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })

        keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

        keymap.set("n", "<leader>fw", function()
            require("telescope.builtin").lsp_document_symbols({
                desc = "List all documents symbols",
                fname_width = 200,
            })
        end)

        keymap.set("n", "<leader>ep", function()
            require("telescope.builtin").find_files({
                cwd = "~/projects/proto/",
            })
        end, { noremap = true, silent = true })

        keymap.set("n", "<leader>eP", function()
            require("telescope.builtin").find_files({
                cwd = "~/projects/atlas/",
            })
        end, { noremap = true, silent = true })

        keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help tags" })

        keymap.set("n", "<leader>en", function()
            require("telescope.builtin").find_files({
                cwd = vim.fn.stdpath("config"),
            })
        end, { noremap = true, silent = true })

        keymap.set("n", "<leader>en", function()
            require("telescope.builtin").find_files({
                cwd = vim.fn.stdpath("config"),
            })
        end, { noremap = true, silent = true })

        keymap.set("n", "<leader>ec", function()
            require("telescope.builtin").find_files({
                cwd = "~/.config/",
            })
        end, { noremap = true, silent = true })

        keymap.set("n", "<leader>gb", function()
            require("telescope.builtin").git_branches({ show_remote_tracking_branches = false })
        end, { noremap = true, silent = true })

        require("kiliand.telescope.multigrep").setup()
    end,
}

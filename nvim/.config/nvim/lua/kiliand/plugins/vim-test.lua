return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	-- config = function()
	-- 	vim.g["test#strategy"] = "dispatch"
	-- end,
	vim.keymap.set("n", "<leader>tt", ":TestNearest<CR>"),
	vim.keymap.set("n", "<leader>tf", ":TestFile<CR>"),
	vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>"),
	vim.keymap.set("n", "<leader>tl", ":TestLast<CR>"),
	vim.keymap.set("n", "<leader>tg", ":TestVisit<CR>"),
}

return {
	"tpope/vim-projectionist",
	config = function()
		vim.g.projectionist_heuristics = {
			["*"] = {
				["*_test.go"] = {
					alternate = "{}.go",
				},
				["*.go"] = {
					alternate = "{}_test.go",
				},
				["*.proto"] = {
					alternate = "../protogen.yml",
					type = "protogen",
				},
			},
		}
		vim.keymap.set("n", "<leader>x", "<cmd>A<CR>", { desc = "Alternate file" })
	end,
}

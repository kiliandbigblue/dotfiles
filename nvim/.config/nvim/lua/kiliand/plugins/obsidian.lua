return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	cond = function()
		return vim.fn.getcwd()
			== "/Users/kiliandemeulemeester/Library/Mobile Documents/iCloud~md~obsidian/Documents/iVault"
	end,
	config = function()
		vim.opt.conceallevel = 1
		require("obsidian").setup({
			workspaces = {
				{
					name = "vault",
					path = "/Users/kiliandemeulemeester/Library/Mobile Documents/iCloud~md~obsidian/Documents/iVault",
				},
			},
		})
	end,
}
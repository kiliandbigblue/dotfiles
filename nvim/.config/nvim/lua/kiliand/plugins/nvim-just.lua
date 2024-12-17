return {
	"kiliandbigblue/nvim-just",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("nvim-just").setup({
			justfile = "/Users/kiliandemeulemeester/projects/cli/justfile",
		})
	end,
}

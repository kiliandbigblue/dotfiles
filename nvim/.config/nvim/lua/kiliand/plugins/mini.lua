return {
	"echasnovski/mini.ai",
	event = "VeryLazy",
	dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
	opts = function()
		local ai = require("mini.ai")
		return {
			custom_textobjects = {
				F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
				o = ai.gen_spec.treesitter({
					a = { "@conditional.outer", "@loop.outer" },
					i = { "@conditional.inner", "@loop.inner" },
				}),
			},
		}
	end,
	config = function(_, opts)
		require("mini.ai").setup(opts)
	end,
}

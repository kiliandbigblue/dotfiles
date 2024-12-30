return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			-- Map of filetype to formatters
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofmt" },
				javascript = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			},
			-- Set this to change the default values when calling conform.format()
			-- This will also affect the default values for format_on_save/format_after_save
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- If this is set, Conform will run the formatter on save.
			-- It will pass the table to conform.format().
			-- This can also be a function that returns the table.
			format_on_save = {
				-- I recommend these options. See :help conform.format for details.
				lsp_format = "fallback",
				timeout_ms = 500,
			},
		})
	end,
}

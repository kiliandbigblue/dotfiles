return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		"giuxtaposition/blink-cmp-copilot",
	},

	version = "v0.8.2",
	opts = {
		keymap = { preset = "default" },

		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
				-- "copilot" ,
			},
			providers = {
				lsp = {
					score_offset = 1000,
				},
				buffer = {
					score_offset = 900,
				},
				path = {
					score_offset = 950,
				},
				snippets = {
					score_offset = 800,
				},
				-- copilot = {
				-- 	name = "copilot",
				-- 	module = "blink-cmp-copilot",
				-- 	score_offset = 100,
				-- 	async = true,
				-- 	transform_items = function(_, items)
				-- 		print(vim.inspect(items))
				-- 		local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
				-- 		local kind_idx = #CompletionItemKind + 1
				-- 		CompletionItemKind[kind_idx] = "Copilot"
				-- 		for _, item in ipairs(items) do
				-- 			item.kind = kind_idx
				-- 		end
				-- 		return items
				-- 	end,
				-- },
			},
		},
		appearance = {
			kind_icons = {
				Copilot = "",
				Text = "󰉿",
				Method = "󰊕",
				Function = "󰊕",
				Constructor = "󰒓",

				Field = "󰜢",
				Variable = "󰆦",
				Property = "󰖷",

				Class = "󱡠",
				Interface = "󱡠",
				Struct = "󱡠",
				Module = "󰅩",

				Unit = "󰪚",
				Value = "󰦨",
				Enum = "󰦨",
				EnumMember = "󰦨",

				Keyword = "󰻾",
				Constant = "󰏿",

				Snippet = "󱄽",
				Color = "󰏘",
				File = "󰈔",
				Reference = "󰬲",
				Folder = "󰉋",
				Event = "󱐋",
				Operator = "󰪚",
				TypeParameter = "󰬛",
			},
		},
	},
	opts_extend = { "sources.default" },
}

local M = {}

local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")

---@diagnostic disable-next-line: deprecated
local flatten = vim.tbl_flatten

local live_multigrep = function(opts)
	opts = opts or {}
	opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()

	local custom_grep = finders.new_async_job({
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				return nil
			end

			local prompt_split = vim.split(prompt, "  ")

			local args = { "rg" }
			if prompt_split[1] then
				table.insert(args, "-e")
				table.insert(args, prompt_split[1])
			end

			if prompt_split[2] then
				table.insert(args, "-g")
				table.insert(args, prompt_split[2])
			end

			if prompt_split[3] then
				table.insert(args, "--glob")
				table.insert(args, prompt_split[3])
			end

			return flatten({
				args,
				{ "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
			})
		end,
		entry_maker = make_entry.gen_from_vimgrep(opts),
		cwd = opts.cwd,
	})

	pickers
		.new(opts, {
			debounce = 100,
			prompt_title = "Live Grep TJ",
			finder = custom_grep,
			previewer = conf.grep_previewer(opts),
			sorter = require("telescope.sorters").empty(),
		})
		:find()
end

M.setup = function()
	vim.keymap.set("n", "<leader>fg", live_multigrep)
end

return M

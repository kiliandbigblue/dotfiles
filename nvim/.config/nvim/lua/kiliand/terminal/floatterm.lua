local M = {}

-- Configuration options with defaults
M.config = {
	height = 0.8, -- Height as a percentage of screen
	width = 0.8, -- Width as a percentage of screen
	border = "rounded", -- Border style
	toggle_key = "<leader>te", -- Default toggle key
}

-- State tracking for the terminal
local terminal_buf = nil
local terminal_win = nil
local is_terminal_open = false

-- Create a floating terminal window
local function create_floating_terminal()
	-- Close existing terminal if it exists
	if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
		vim.api.nvim_win_close(terminal_win, true)
	end

	if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
		vim.api.nvim_buf_delete(terminal_buf, { force = true })
	end

	-- Calculate width based on percentage
	local width = math.floor(vim.o.columns * M.config.width)
	local height = math.floor(vim.o.lines * M.config.height)

	-- Calculate window position to center it
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- Create a new buffer
	terminal_buf = vim.api.nvim_create_buf(false, true)

	-- Create floating window
	terminal_win = vim.api.nvim_open_win(terminal_buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = M.config.border,
	})

	-- Start terminal in current working directory
	vim.fn.termopen(vim.o.shell, {
		cwd = vim.fn.getcwd(),
		on_exit = function()
			-- Ensure we clean up if the terminal window is still valid
			if vim.api.nvim_win_is_valid(terminal_win) then
				vim.api.nvim_win_close(terminal_win, true)
			end

			-- Reset terminal state
			terminal_win = nil
			terminal_buf = nil
			is_terminal_open = false
		end,
	})

	-- Set buffer-local options for terminal
	vim.api.nvim_buf_set_option(terminal_buf, "bufhidden", "wipe")

	-- Enter terminal mode
	vim.cmd("startinsert")

	is_terminal_open = true
end

-- Toggle terminal visibility
function M.toggle_terminal()
	if is_terminal_open then
		-- Close terminal if open
		if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
			vim.api.nvim_win_close(terminal_win, true)
		end

		-- Reset state
		terminal_win = nil
		terminal_buf = nil
		is_terminal_open = false
	else
		-- Show terminal
		create_floating_terminal()
	end
end

-- Setup function to configure the module
function M.setup(opts)
	-- Merge user config with defaults
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})

	-- Set up keymap to toggle terminal
	vim.keymap.set("n", M.config.toggle_key, M.toggle_terminal, { noremap = true, silent = true })
end

return M

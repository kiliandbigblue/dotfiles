vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", ":Oil<CR>")

-- Move line arounds in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]]) -- delete without yanking

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>s", [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>b", ":cclose<CR>")

vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>gh", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "<leader>gl", "<cmd>diffget //3<CR>")

vim.keymap.set("n", "<leader>tl", ":e ~/todo/todo.txt<CR>")

vim.keymap.set("n", "[d", "[dzz")
vim.keymap.set("n", "]d", "dzz")
vim.keymap.set("n", "[q", ":cprevious<CR>zz")
vim.keymap.set("n", "]q", ":cnext<CR>zz")

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")

function RpcToGoFunc()
	-- Get the current line under the cursor
	local rpc_line = vim.fn.getline(".")

	-- Pattern to match the rpc declaration
	local rpc_pattern = "rpc%s+(%w+)%((%w+)%)%s+returns%s+%((%w+)%)"

	-- Extract function name, request type, and response type using Lua pattern matching
	local func_name, request_type, response_type = string.match(rpc_line, rpc_pattern)

	-- If matching was successful, construct the Go function signature
	if func_name and request_type and response_type then
		-- Prepare the Go function signature
		local go_func = string.format(
			"func (s *Service) %s(ctx context.Context, r *inventory.%s) (*inventory.%s, error) { return nil, nil }",
			func_name,
			request_type,
			response_type
		)

		-- Replace the current line with the generated Go function signature
		vim.fn.setline(".", go_func)
	else
		-- Notify user in case of pattern mismatch
		print("Pattern match failed. Please ensure the line follows the RPC format.")
	end
end
vim.api.nvim_create_user_command("RpcToGoFunc", RpcToGoFunc, {})

function GithubPR()
	vim.fn.system("gh pr view --web")
end
vim.api.nvim_create_user_command("GithubPR", GithubPR, {})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

return {
	"kazhala/close-buffers.nvim",
	dependencies = "akinsho/bufferline.nvim",
	config = function()
		require("close_buffers").setup({
			preserve_window_layout = { "this" },
			next_buffer_cmd = function(windows)
				require("bufferline").cycle(1)
				local bufnr = vim.api.nvim_get_current_buf()

				for _, window in ipairs(windows) do
					vim.api.nvim_win_set_buf(window, bufnr)
				end
			end,
		})

		vim.api.nvim_set_keymap(
			"n",
			"<leader>oo",
			[[<CMD>lua require('close_buffers').wipe({type = 'other'})<CR>]],
			{ noremap = true, silent = true, desc = "Wipe all buffers except current focus" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>oc",
			[[<CMD>lua require('close_buffers').delete({type = 'this'})<CR>]],
			{ noremap = true, silent = true, desc = "Delete the current buffer" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>oh",
			[[<CMD>lua require('close_buffers').delete({type = 'hidden'})<CR>]],
			{ noremap = true, silent = true, desc = "Delete all non-visibile buffers" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>on",
			[[<CMD>lua require('close_buffers').delete({type = 'nameless'})<CR>]],
			{ noremap = true, silent = true, desc = "Delete all buffers without a name" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>oa",
			[[<CMD>lua require('close_buffers').wipe({type = 'all', force=true})<CR>]],
			{ noremap = true, silent = true, desc = "Wipe all buffers" }
		)
	end,
}

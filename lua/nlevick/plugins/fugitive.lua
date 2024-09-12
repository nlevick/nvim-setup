return {
	"tpope/vim-fugitive",
	config = function()
		local keymap = vim.keymap

		keymap.set("n", "<leader>gg", function()
			vim.cmd(":tab Git")
		end)
		keymap.set("n", "<leader>gx", function()
			vim.cmd("vert Git")
		end, { desc = "git fugitive" })
		keymap.set("n", "gf", "<cmd>diffget //2<CR>", { desc = "Take left changes" })
		keymap.set("n", "gj", "<cmd>diffget //3<CR>", { desc = "Take right changes" })
	end,
}

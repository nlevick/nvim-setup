return {
	"mbbill/undotree",
	config = function()
		local keymap = vim.keymap
		keymap.set("n", "<leader>u", function()
			keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
			vim.cmd("UndotreeToggle | UndotreeFocus")
		end)
	end,
}

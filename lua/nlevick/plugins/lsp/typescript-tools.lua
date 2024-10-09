return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	event = "VeryLazy",
	config = function()
		local keymap = vim.keymap
		keymap.set("n", "<leader>is", "<cmd>TSToolsSortImports<CR><cmd>w<CR>", { desc = "Sort imports" })
		keymap.set(
			"n",
			"<leader>ir",
			"<cmd>TSToolsRemoveUnusedImports<CR><cmd>w<CR>",
			{ desc = "Remove unused imports" }
		)
		keymap.set("n", "<leader>ia", "<cmd>TSToolsAddMissingImports<CR><cmd>w<CR>", { desc = "Add missing imports" })

		local tsTools = require("typescript-tools")

		tsTools.setup({
			settings = {
				tsserver_plugins = {
					"@styled/typescript-styled-plugin",
				},
			},
		})
	end,
}

return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	event = "VeryLazy",
	config = function()
		local keymap = vim.keymap
		keymap.set("n", "<leader>i", "<cmd>TSToolsSortImports<CR>", { desc = "TSTools sort imports" })
		keymap.set("n", "<leader>ir", "<cmd>TSToolsRemoveUnusedImports<CR>", { desc = "TSTools remove unused imports" })

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

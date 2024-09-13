return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	event = "VeryLazy",
	config = function()
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

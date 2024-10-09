return {
	"nvim-pack/nvim-spectre",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local spectre = require("spectre")
		spectre.setup({
			lnum_for_results = true,
			use_trouble_qf = true,
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>S", spectre.toggle, {
			desc = "Toggle Spectre",
		})

		keymap.set({ "n", "v" }, "<leader>sw", function()
			spectre.open_visual({ select_word = true })
		end, { desc = "Search current word" })

		keymap.set("v", "<leader>sf", function()
			spectre.open_file_search({ select_word = true })
		end, { desc = "Search on current file" })
	end,
}

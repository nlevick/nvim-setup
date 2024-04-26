return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- custom mappings
			vim.keymap.set("n", "<C-x>", api.node.open.vertical, opts("Open: Vertical Split"))
		end

		nvimtree.setup({
			on_attach = my_on_attach,
			view = {
				width = 40,
				relativenumber = true,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		keymap.set("n", "<leader>yy", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		keymap.set("n", "<leader>yf", "<cmd>NvimTreeFindFile<CR>", { desc = "Find file in explorer" })
		keymap.set("n", "<leader>yc", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
		keymap.set("n", "<leader>yr", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
	end,
}

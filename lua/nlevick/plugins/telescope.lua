return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-x>"] = "select_vertical",
						["<C-o>"] = function(prompt_bufnr) -- open file under cursor in tab, resume
							require("telescope.actions").select_tab(prompt_bufnr)
							require("telescope.builtin").resume()
						end,
					},
				},
			},
		})

		--   telescope.load_extension("fzf")
		local builtin = require("telescope.builtin")
		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		-- keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

		-- Browse directories
		keymap.set(
			"n",
			"<leader>hh",
			[[<Cmd>lua require'telescope.builtin'.find_files({prompt_title = ' Home Browse', cwd = '~', layout_strategy = 'horizontal', layout_config = { preview_width = 0.65, width = 0.75 }})<CR>]],
			{ desc = "Browse home directory" }
		)
		keymap.set(
			"n",
			"<leader>nn",
			[[<Cmd>lua require'telescope.builtin'.find_files({prompt_title = ' NVim Config Browse', cwd = '~/AppData/local/nvim/', layout_strategy = 'horizontal', layout_config = { preview_width = 0.65, width = 0.75 }})<CR>]],
			{ desc = "Browse nvim config" }
		)

		-- GIT
		keymap.set(
			"n",
			"<leader>gc",
			[[<Cmd>lua require'telescope.builtin'.git_bcommits({prompt_title = '  ', results_title='Git File Commits'})<CR>]],
			{ desc = "Search git commits" }
		)

		keymap.set(
			"n",
			"<leader>gb",
			[[<Cmd>lua require'telescope.builtin'.git_branches({prompt_title = ' ', results_title='Git Branches'})<CR>]],
			{ desc = "Search git branches" }
		)
		keymap.set("n", "<leader>gs", builtin.git_stash, { desc = "Search git commits" })

		-- LSP
		keymap.set(
			"n",
			",k",
			[[<Cmd>lua require'telescope.builtin'.keymaps({results_title='Key Maps Results'})<CR>]],
			{ desc = "Search keymaps", noremap = true, silent = true }
		)
		keymap.set("n", ",c", builtin.commands, {})
		keymap.set(
			"n",
			"<leader>b",
			[[<Cmd>lua require'telescope.builtin'.buffers({prompt_title = 'Search Buffers', results_title='Open Buffers', winblend = 3, layout_strategy = 'vertical', layout_config = { width = 0.60, height = 0.55 }})<CR>]],
			{ desc = "Search buffers", noremap = true, silent = true }
		)

		keymap.set(
			"n",
			",h",
			[[<Cmd>lua require'telescope.builtin'.help_tags({results_title='Help Results'})<CR>]],
			{ desc = "Search help", noremap = true, silent = true }
		)

		keymap.set(
			{ "n", "v" },
			",r",
			[[<Cmd>lua require'telescope.builtin'.registers({results_title='Register Results'})<CR>]],
			{ desc = "Search registers", noremap = true, silent = true }
		)

		keymap.set(
			"n",
			",m",
			[[<Cmd>lua require'telescope.builtin'.marks({results_title='Marks Results'})<CR>]],
			{ desc = "Search marks", noremap = true, silent = true }
		)

		-- SEARCH
		keymap.set("n", "<leader>R", builtin.resume, { desc = "Resume last telescope search" })
		-- git repo: path
		keymap.set("n", "<C-t>", builtin.git_files, { desc = "Browse git files" })
		-- directory (and children): path
		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		-- directory: path and file content
		keymap.set(
			"n",
			"<leader>fa",
			[[<Cmd>lua require'telescope.builtin'.live_grep()<CR>]],
			{ noremap = true, silent = true, desc = "Live grep" }
		)
		-- open buffer: content
		keymap.set(
			"n",
			"<leader>fo",
			[[<Cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>]],
			{ noremap = true, silent = true, desc = "Live grep open buffers" }
		)
		-- current buffer: content
		keymap.set(
			"n",
			"<leader>fb",
			[[<Cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find()<CR>]],
			{ noremap = true, silent = true, desc = "Search in current buffer" }
		)
	end,
}

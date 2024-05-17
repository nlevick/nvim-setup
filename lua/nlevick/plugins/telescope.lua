return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "TelescopeResults",
			callback = function(ctx)
				vim.api.nvim_buf_call(ctx.buf, function()
					vim.fn.matchadd("TelescopeParent", "\t\t.*$")
					vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
				end)
			end,
		})

		local function filenameFirst(_, path)
			local tail = vim.fs.basename(path)
			local parent = vim.fs.dirname(path)
			if parent == "." then
				return tail
			end
			return string.format("%s\t\t%s", tail, parent)
		end

		telescope.setup({
			defaults = {
				-- path_display = { shorten = { len = 3, exclude = { -1 } } },
				path_display = filenameFirst,
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
			extensions = {
				live_grep_args = {
					auto_quoting = false, -- enable/disable auto-quoting
					mappings = { -- extend mappings
						i = {
							["<C-e>"] = require("telescope-live-grep-args.actions").quote_prompt({
								postfix = " -Thtml",
							}),
						},
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")
		local builtin = require("telescope.builtin")
		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set(
			"n",
			"<leader>fc",
			require("telescope-live-grep-args.shortcuts").grep_word_under_cursor,
			{ desc = "Find string under cursor in cwd" }
		)
		keymap.set("v", "<leader>fv", require("telescope-live-grep-args.shortcuts").grep_visual_selection)
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
		keymap.set("n", "<C-p>", builtin.git_files, { desc = "Browse git files" })
		-- directory (and children): path
		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		-- directory: path and file content
		keymap.set(
			"n",
			"<leader>fa",
			require("telescope").extensions.live_grep_args.live_grep_args,
			{ noremap = true, silent = true, desc = "Live grep in cwd" }
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

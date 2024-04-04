local telescope = require('telescope')

telescope.setup {
    defaults = {
        file_ignore_patterns = { "%.js.html", "%.jsx.html", "%.ts.html", "%.tsx.html" },
        mappings = {
            i = {
                ["<C-x>"] = "select_vertical",
                ["<C-o>"] = function(prompt_bufnr)
                    require("telescope.actions").select_tab(prompt_bufnr)
                    require("telescope.builtin").resume()
                end,
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
            },
        },
    },
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>pb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>ps', builtin.git_stash, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>pg', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

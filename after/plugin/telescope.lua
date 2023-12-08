local telescope = require('telescope')

-- Configure key mappings
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-x>"] = "select_vertical",
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



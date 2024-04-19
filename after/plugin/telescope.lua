local telescope = require('telescope')
local lga_actions = require('telescope-live-grep-args.actions')

telescope.setup {
    defaults = {
        path_display = { 'shorten' },
        vimgrep_arguments = {
            'rg',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
        },
        file_ignore_patterns = { '%.js.html', '%.jsx.html', '%.ts.html', '%.tsx.html' },
        mappings = {
            i = {
                ['<C-x>'] = 'select_vertical',
                ['<C-o>'] = function(prompt_bufnr)
                    require('telescope.actions').select_tab(prompt_bufnr)
                    require('telescope.builtin').resume()
                end,
                ['<C-j>'] = 'move_selection_next',
                ['<C-k>'] = 'move_selection_previous',
            },
        },
    },
    extensions = {
        live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            mappings = {         -- extend mappings
                i = {
                    ['<C-e>'] = lga_actions.quote_prompt(),
                },
            },
        }
    }
}

local builtin = require('telescope.builtin')

-- Browse directories
vim.keymap.set('n', '<leader>hh',
    [[<Cmd>lua require'telescope.builtin'.find_files({prompt_title = ' Home Browse', cwd = '~', layout_strategy = 'horizontal', layout_config = { preview_width = 0.65, width = 0.75 }})<CR>]])
vim.keymap.set('n', '<leader>nn',
    [[<Cmd>lua require'telescope.builtin'.find_files({prompt_title = ' NVim Config Browse', cwd = '~/AppData/local/nvim/', layout_strategy = 'horizontal', layout_config = { preview_width = 0.65, width = 0.75 }})<CR>]])

-- GIT
vim.keymap.set('n', '<leader>gc',
    [[<Cmd>lua require'telescope.builtin'.git_bcommits({prompt_title = '  ', results_title='Git File Commits'})<CR>]])
vim.keymap.set('n', '<leader>gb',
    [[<Cmd>lua require'telescope.builtin'.git_branches({prompt_title = ' ', results_title='Git Branches'})<CR>]])
vim.keymap.set('n', '<leader>gs', builtin.git_stash, {})

-- LSP
vim.keymap.set(
    'n',
    ',k',
    [[<Cmd>lua require'telescope.builtin'.keymaps({results_title='Key Maps Results'})<CR>]],
    { noremap = true, silent = true }
)
vim.keymap.set('n', ',c', builtin.commands, {})
vim.keymap.set(
    'n',
    '<leader>b',
    [[<Cmd>lua require'telescope.builtin'.buffers({prompt_title = 'Search Buffers', results_title='Open Buffers', winblend = 3, layout_strategy = 'vertical', layout_config = { width = 0.60, height = 0.55 }})<CR>]],
    { noremap = true, silent = true }
)

vim.keymap.set(
    'n',
    ',h',
    [[<Cmd>lua require'telescope.builtin'.help_tags({results_title='Help Results'})<CR>]],
    { noremap = true, silent = true }
)

vim.keymap.set(
    { 'n', 'v' },
    ',r',
    [[<Cmd>lua require'telescope.builtin'.registers({results_title='Register Results'})<CR>]],
    { noremap = true, silent = true }
)

vim.keymap.set(
    'n',
    ',m',
    [[<Cmd>lua require'telescope.builtin'.marks({results_title='Marks Results'})<CR>]],
    { noremap = true, silent = true }
)

-- SEARCH
vim.keymap.set('n', '<leader>R', builtin.resume, {})
-- git repo: path
vim.keymap.set('n', '<C-t>', builtin.git_files, {})
-- directory (and children): path
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- directory: path and file content
vim.keymap.set('n', '<leader>fa', [[<Cmd>lua require'telescope.builtin'.live_grep()<CR>]],
    { noremap = true, silent = true })
-- open buffer: content
vim.keymap.set(
    'n',
    '<leader>fo',
    [[<Cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>]],
    { noremap = true, silent = true }
)
-- current buffer: content
vim.keymap.set(
    'n',
    '<leader>fb',
    [[<Cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find()<CR>]],
    { noremap = true, silent = true }
)

-- RIPGREP
vim.keymap.set('n', '<leader>rg', require('telescope-live-grep-args.shortcuts').grep_word_under_cursor)
vim.keymap.set('v', '<leader>rv', require('telescope-live-grep-args.shortcuts').grep_visual_selection)
vim.keymap.set('n', '<leader>fr', require('telescope').extensions.live_grep_args.live_grep_args, { noremap = true })

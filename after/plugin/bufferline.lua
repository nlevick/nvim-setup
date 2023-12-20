-- vim.opt.termguicolors = true
local bufferline = require("bufferline")
bufferline.setup({
    options = {
        mode = "tabs",
        separator_style = 'slant',
        -- always_show_bufferline = true,
        -- show_buffer_close_icons = true,
        -- show_close_icon = true,
        color_icons = true,
        numbers = "ordinal",
        indicator = {
            style = 'underline'
        },
        style_preset = bufferline.style_preset.no_italic
    },
    -- highlights = {
    --     separator = {
    --         fg = '#073642',
    --         bg = '#002b36',
    --     },
    --     separator_selected = {
    --         fg = '#073642',
    --     },
    --     background = {
    --         fg = '#657b83',
    --         bg = '#002b36'
    --     },
    --     buffer_selected = {
    --         fg = '#fdf6e3',
    --         bold = true
    --     },
    --     fill = {
    --         bg = '#073642'
    --     }
    -- },
})

vim.keymap.set('n', '<leader><Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<leader><S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})

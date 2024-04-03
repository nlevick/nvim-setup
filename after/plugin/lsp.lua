local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gn", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'gd', function()
        local org_path = vim.api.nvim_buf_get_name(0)

        -- Go to definition:
        vim.api.nvim_command('normal gD')

        -- Wait LSP server response
        vim.wait(100, function() end)

        local new_path = vim.api.nvim_buf_get_name(0)
        if not (org_path == new_path) then
            -- Create a new tab for the original file
            vim.api.nvim_command('0tabnew %')

            -- Restore the cursor position
            vim.api.nvim_command('b ' .. org_path)
            vim.api.nvim_command('normal! `"')

            -- Switch to the original tab
            vim.api.nvim_command('normal! gt')
        end
    end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'tsserver' },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- Require function for tab to work with LUA-SNIP
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local luasnip = require("luasnip")

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
    },
    snippet = {
        expand = function(args)
            if not luasnip then
                return
            end
            luasnip.lsp_expand(args.body)
        end,
    },
    formatting = {
        -- fields = { 'menu', 'abbr', 'kind' },
        format = require('lspkind').cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,         -- prevent the popup from showing more than provided characters
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
            before = function(entry, vim_item)
                vim_item.menu = ({
                    buffer = "[Ω BUFF]",
                    nvim_lsp = "[λ LSP]",
                    luasnip = "[⋗ SNIP]",
                    path = "[🖫 PATH]",
                    nvim_lua = "[Π LUA]",
                })[entry.source.name]
                return vim_item
            end
        })
    },
    -- formatting = {
    --     -- changing the order of fields so the icon is the first
    --     fields = { 'menu', 'abbr', 'kind' },

    --     -- here is where the change happens
    --     format = function(entry, item)
    --         local menu_icon = {
    --             nvim_lsp = 'λ',
    --             luasnip = '⋗',
    --             buffer = 'Ω',
    --             path = '🖫',
    --             nvim_lua = 'Π',
    --         }

    --         item.menu = menu_icon[entry.source.name]
    --         return item
    --     end,
    -- },
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }
        ),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }
        ),
    }),
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

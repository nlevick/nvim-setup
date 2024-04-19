-- -- This file can be loaded by calling `lua require('plugins')` from your init.vi

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use({
        'talha-akram/noctis.nvim',
        as = 'noctis',
        config = function()
            vim.cmd('colorscheme noctis')
        end
    })

    use({
        'tanvirtin/monokai.nvim',
        as = 'monokai',
        config = function()
            vim.cmd('colorscheme monokai_pro')
        end
    })

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = {
            { "nvim-telescope/telescope-live-grep-args.nvim" },
            { 'nvim-lua/plenary.nvim' } },
        config = function()
            require("telescope").load_extension("live_grep_args")
        end
    }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
        }
    }

    use {
        'L3MON4D3/LuaSnip',
        requires = {
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
            'onsails/lspkind-nvim'
        },
    }

    use('jose-elias-alvarez/null-ls.nvim')
    use('MunifTanjim/prettier.nvim')

    use "terrortylor/nvim-comment"

    use 'nvim-tree/nvim-web-devicons'

    use 'nvim-lualine/lualine.nvim'

    use { 'akinsho/bufferline.nvim', tag = "*" }

    use 'norcalli/nvim-colorizer.lua'

    use 'windwp/nvim-ts-autotag'
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use 'lewis6991/gitsigns.nvim'
    use 'nvim-tree/nvim-tree.lua'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)

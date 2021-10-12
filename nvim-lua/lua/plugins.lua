--[[

░█▀█░█░█░▀█▀░█▄█░░░█░░░█░█░█▀█░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀
░█░█░▀▄▀░░█░░█░█░░░█░░░█░█░█▀█░░░█░░░█░█░█░█░█▀▀░░█░░█░█
░▀░▀░░▀░░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀

patrick's neovim configuration

changes:

(10/12/2021)
    - statusline updates (inherit system theme)
    - fix luasnip+cmp
    - gitsigns color fixes

(10/05/2021)
    - initial changes
    - still has a bunch of VimL extensions
--]]


require('packer').startup(function(use)
    -- let packer manage itself
    use 'wbthomason/packer.nvim'


    -- NATIVE LUA PLUGINS --


    -- language server setup
    use {
        'neovim/nvim-lspconfig',
        config = function() 
            require('plugins/nvim-lspconfig')
        end
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        },
        config = function()
            require('plugins/nvim-cmp')
        end
    }

    -- gitgutter 
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('plugins/gitsigns')
        end
    }

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- treesitter: make use of incremental parsing
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- nvim tree: nerdtree equivalent
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'nvim-tree'.setup {} end
    }

    -- nvim project: autocd to project root
    use {
        'ahmedkhalf/project.nvim',
        config = function()
            require("project_nvim").setup {}
            require('telescope').load_extension('projects')
        end
    }

    -- lualine: statusline
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function()
            require('plugins/lualine')
        end
    }


    --- VIM EXTENSIONS ---

    -- general
    use 'tpope/vim-sensible'

    -- movement
    use 'junegunn/vim-easy-align'
    use 'terryma/vim-multiple-cursors'
    use 'easymotion/vim-easymotion'
    use 'tpope/vim-commentary'

    -- language support
    use 'pkage/sparkup'
    use 'elzr/vim-json'

    -- latex support
    use 'junegunn/goyo.vim'
    use 'junegunn/limelight.vim'
end)


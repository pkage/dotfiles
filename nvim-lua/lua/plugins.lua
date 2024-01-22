--[[

░█▀█░█░█░▀█▀░█▄█░░░█░░░█░█░█▀█░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀
░█░█░▀▄▀░░█░░█░█░░░█░░░█░█░█▀█░░░█░░░█░█░█░█░█▀▀░░█░░█░█
░▀░▀░░▀░░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀

patrick's neovim configuration

changes:

(12/09/2021)
    - disable project.nvim

(11/13/2021)
    - julia support

(11/09/2021)
    - toml support

(10/19/2021)
    - ejs support

(10/12/2021)
    - statusline updates (inherit system theme)
    - fix luasnip+cmp
    - gitsigns color fixes

(10/05/2021)
    - initial changes
    - still has a bunch of VimL extensions

(05/05/2022)
    - configure treesitter

(07/18/2022)
    - add docstring generator

(07/21/2022)
    - add spellchecker for neovim

(08/01/2022)
    - remove stable tag for neogen

(09/11/2022)
    - replace easymotion with hop.nvim
    - replace goyo and limelight with zen-mode and twilight
    - finally fix cmp supertab
    - install luasnip properly
    - add typescript support
    - add colorscheme

(09/27/2022)
    - add luapad for nvim plugin dev

(02/19/2023)
    - fix hop

(06/23/2023)
    - add Nix support
    - remove coauthor (for now)

(07/07/2023)
    - fix hop again
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

    use { 'L3MON4D3/LuaSnip', run = "make install_jsregexp" }
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
        run = ':TSUpdate',
        config = function()
            require('plugins/nvim-treesitter')
        end
    }

    -- nvim tree: nerdtree equivalent
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'nvim-tree'.setup {} end
    }

    -- nvim project: autocd to project root
    -- use {
    --     'ahmedkhalf/project.nvim',
    --     config = function()
    --         require("project_nvim").setup {}
    --         require('telescope').load_extension('projects')
    --     end
    -- }

    -- lualine: statusline
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function()
            require('plugins/lualine')
        end
    }

    -- neogen: docstring generator
    use {
        "danymat/neogen",
        config = function()
            require('neogen').setup {
                enabled = true,
                input_after_comment = true,
                languages = {
                    python = {
                        template = {
                            annotation_convention = 'reST'
                        }
                    }   
                }
            }
        end,
        requires = "nvim-treesitter/nvim-treesitter"
        -- tag = "*"
    }

    -- spellsitter: syntax aware spellcheck
    use {
        'lewis6991/spellsitter.nvim',
        config = function()
            require('spellsitter').setup()
        end
    }

    -- hop: easymotion but without modifying buffers
    use {
        'smoka7/hop.nvim',
        -- branch = 'v2', -- optional but strongly recommended
        tag = '*',
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require'hop'.setup {}
        end
    }

    -- zen-mode.nvim: neovim focus writing mode
    use {
        'folke/zen-mode.nvim',
        config = function()
            require('zen-mode').setup {
                window = {
                    width = 85,
                    options = {
                        number = false,
                        signcolumn = "no"
                    }
                },
                plugins = {
                    gitsigns = { enabled = true },
                }
            }
        end
    }

    -- twilight.nvim: dim areas of text that aren't being interacted with
    use {
        'folke/twilight.nvim',
        config = function()
            require('twilight').setup {
              -- disable treesitter and just use line context for now
              -- TODO: should investigate correct treesitter tags
              treesitter = false 
            }
        end
    }

    -- nvim luapad - lua scratchpad
    use {
        'rafcamlet/nvim-luapad',
        opt = true, cmd = {'Luapad'},
        requires = 'antoinemadec/FixCursorHold.nvim'
    }

    -- use {
    --     '~/Repositories/python/coauthor.nvim',
    --     requires = { 'nvim-lua/plenary.nvim' },
    --     config = function()
    --         -- default configuration options shown
    --         require('coauthor').setup({
    --             server_uri = 'http://dt.ts.ka.ge:8012',
    --             max_length = 256
    --         })
    --     end
    -- }


    -- moonfly: color scheme
    use 'bluz71/vim-moonfly-colors'


    -- fun: destroy your code
    use 'eandrju/cellular-automaton.nvim'

    --- VIM EXTENSIONS ---

    -- general
    use 'tpope/vim-sensible'

    -- movement
    use 'junegunn/vim-easy-align'
    use 'terryma/vim-multiple-cursors'
    -- use 'easymotion/vim-easymotion'
    use 'tpope/vim-commentary'

    -- language support
    use 'pkage/sparkup'
    use 'elzr/vim-json'
    -- use 'vieira/vim-javascript'
    use 'isobit/vim-caddyfile'
    use 'cespare/vim-toml'
    use 'LnL7/vim-nix'
    use 'smerrill/vcl-vim-plugin'
    use 'JuliaEditorSupport/julia-vim'
    use {
        'evanleck/vim-svelte',
        config = function()
            require('plugins/vim-svelte')
        end
    }

    use {
        'vim-python/python-syntax',
        config = function()
            vim.g.python_highlight_all = 1
        end
    }

    -- latex support
    -- use 'junegunn/goyo.vim'
    -- use 'junegunn/limelight.vim'
end)


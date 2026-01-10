return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform",
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        opts = function()
            return require ".configs.nvimtree"
        end,
    },

    -- test new blink
    { import = "nvchad.blink.lazyspec" },

    --- attempt to support devcontainers
    {
        'https://codeberg.org/esensar/nvim-dev-container',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        lazy=false,
        opts = function()
            require("devcontainer").setup{}
        end
    },

    -- {
    -- 	"nvim-treesitter/nvim-treesitter",
    -- 	opts = {
    -- 		ensure_installed = {
    -- 			"vim", "lua", "vimdoc",
    --      "html", "css"
    -- 		},
    -- 	},
    -- },
    --
    --
    -- quality of life
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = function ()
            -- dofile(vim.g.base46_cache .. "hop")
            return {
                keys = 'etovxqpdygfblzhckisuran'
            }
        end
    },
    { 'junegunn/vim-easy-align', lazy=false},
    {
        'terryma/vim-multiple-cursors',
        lazy=false
    },
    -- various language support
    { 'elzr/vim-json' },
    { 'cespare/vim-toml' },
    {
        'pkage/sparkup',
        ft = {"html", "htmldjango", "njk", "smarty", "svelte", "xml"}
    },

    -- lazygit
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    }
}

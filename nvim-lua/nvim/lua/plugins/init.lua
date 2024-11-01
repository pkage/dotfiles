return {
  
  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

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
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",

        "c",
        "rust",
        "javascript",
        "typescript",
        "latex",
        "julia",
        "svelte",
        "python"

  		},
      sync_install = false,
      highlight = {
        enable=true
      }
  	},
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require ".configs.nvimtree"
    end,
  },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
  },

  {
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
  },

  -- quality of life
  {
    'smoka7/hop.nvim',
    version = "*",
    opts = function ()
      dofile(vim.g.base46_cache .. "hop")
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


  --- writing
  { 'folke/twilight.nvim' },
  {
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
  },

  -- various language support
  { 'elzr/vim-json' },
  { 'cespare/vim-toml' },
  {
    'pkage/sparkup',
    ft = {"html", "htmldjango", "njk", "smarty", "svelte", "xml"}
  },
}

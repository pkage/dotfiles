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
      return {
        delay = function(ctx)
          return ctx.plugin and 0 or 750
        end
      }
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
  {
    "yetone/avante.nvim",
    cmd = { "AvanteAsk", "AvanteEdit", "AvanteRefresh", "AvanteToggle", "AvanteShowRepoMap" },
    keys = {
        { '<leader>aa', '<cmd>AvanteAsk<cr>', desc = 'avante: ask' }
    },
    -- event = "VeryLazy",
    -- lazy = true,
    version = false, -- set this if you want to always pull the latest change
    opts = function ()
      dofile(vim.g.base46_cache .. "avante")
      return {
        provider = "openai",
        openai = {
            model = 'gpt-4o'
        }
      }
    end,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "Avante" }, -- only render in avante
        },
        ft = { "Avante" },
      },
    },
  },

  --- writing
  { 'folke/twilight.nvim', lazy=false },
  {
    'folke/zen-mode.nvim',
    lazy=false,
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
                    twilight = { enabled = false },
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
  -- {
  --   "lervag/vimtex",
  --   lazy = false,     -- we don't want to lazy load VimTeX
  --   -- tag = "v2.15", -- uncomment to pin to a specific release
  --   init = function()
  --     -- VimTeX configuration goes here, e.g.
  --     vim.g.vimtex_view_method = "skim"
  --     -- vim.g.vimtex_syntax_conceal = {}
  --   end
  -- }

}

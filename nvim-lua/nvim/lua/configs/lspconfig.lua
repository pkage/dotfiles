require("nvchad.configs.lspconfig").defaults()
require 'configs.docker_ros_lsp'

local servers = { "html", "cssls", 'pyright', 'rust_analyzer' }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 

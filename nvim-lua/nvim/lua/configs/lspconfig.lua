-- require 'configs.docker_ros_lsp'
require("nvchad.configs.lspconfig").defaults()

local servers = { 
    'html',
    'cssls',
    'pyright',
    'rust_analyzer',
    -- 'docker_ros_pyright'
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 

--[[
-- lua/lsp/docker.lua
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

-- change these if compose service name differs
local compose_service = "ros"

local function docker_cmd(cmd)
    -- cmd is a list like {"pylsp"} or {"clangd", "--background-index"}
    return vim.list_extend({ "docker", "compose", "exec", "-T", compose_service }, cmd)
end

-- Register a new server only once
if not configs.docker_ros_pyright then
    configs.docker_ros_pyright = {
        default_config = {
            name = "docker_ros_pyright",
            cmd = { "docker", "exec", "-i", "onboard-ros-1", "pyright-langserver", "--stdio" },
            -- cmd = { "docker", "compose", "exec", "-T", compose_service, "pyright-langserver", "--stdio" },
            -- cmd = { './scripts/lsp.sh' },
            -- Add this section to explicitly inherit variables
            cmd_env = {
                DOCKER_HOST = "unix://" .. os.getenv("HOME") .. "/.orbstack/run/docker.sock",
                DOCKER_CONTEXT = vim.env.DOCKER_CONTEXT,
                PATH = vim.env.PATH, -- Crucial for helper binaries
            },
            filetypes = { "python" },
            root_dir = util.root_pattern("docker-compose.yml", "docker-compose.yaml", ".neovim-docker-ros"),
            single_file_support = true,
        },
    }
end


lspconfig.docker_ros_pyright.setup({})
--]]

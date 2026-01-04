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
            -- my config
            name = "docker_ros_pyright",
            -- cmd = { "docker", "exec", "-i", "onboard-ros-1", "pyright-langserver", "--stdio" },
            cmd = { "docker", "compose", "exec", "-T", compose_service, "pyright-langserver", "--stdio" },
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
            -- cmd = { 'pyright-langserver', '--stdio' },
            -- filetypes = { 'python' },
            -- root_markers = {
            --     'pyrightconfig.json',
            --     'pyproject.toml',
            --     'setup.py',
            --     'setup.cfg',
            --     'requirements.txt',
            --     'Pipfile',
            --     '.git',
            -- },
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = 'openFilesOnly',
                    },
                },
            },

            -- fixes issue with lang server being killed
            before_init = function(params)
                params.processId = vim.NIL
            end,

            init = function()
                local make_client_capabilities = vim.lsp.protocol.make_client_capabilities
                function vim.lsp.protocol.make_client_capabilities()
                    local caps = make_client_capabilities()
                    if caps.workspace then
                        caps.workspace.didChangeWatchedFiles = nil
                    end
                    return caps
                end
            end,
            on_attach = function(client, bufnr)
                vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
                    local params = {
                        command = 'pyright.organizeimports',
                        arguments = { vim.uri_from_bufnr(bufnr) },
                    }

                    -- Using client.request() directly because "pyright.organizeimports" is private
                    -- (not advertised via capabilities), which client:exec_cmd() refuses to call.
                    -- https://github.com/neovim/neovim/blob/c333d64663d3b6e0dd9aa440e433d346af4a3d81/runtime/lua/vim/lsp/client.lua#L1024-L1030
                    ---@diagnostic disable-next-line: param-type-mismatch
                    client.request('workspace/executeCommand', params, nil, bufnr)
                end, {
                        desc = 'Organize Imports',
                    })
            end
        }
    }

    -- vim.lsp.config('docker_ros_pyright', configs.docker_ros_pyright)
end


lspconfig.docker_ros_pyright.setup({})
vim.lsp.enable('docker_ros_pyright')

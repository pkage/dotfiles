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

--[[

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

        }
    }

    -- vim.lsp.config('docker_ros_pyright', configs.docker_ros_pyright)
end


lspconfig.docker_ros_pyright.setup({

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
})
vim.lsp.enable('docker_ros_pyright')
--]]


-- Create an autocommand group so we don't duplicate listeners on reload
local group = vim.api.nvim_create_augroup("DockerLspConfig", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    group = group,
    callback = function(ev)
        -- 1. Find the project root (where docker-compose.yml lives)
        local root_pattern = { "docker-compose.yml", ".neovim-docker-ros" }
        local root_dir = vim.fs.dirname(vim.fs.find(root_pattern, { upward = true, path = ev.file })[1])

        -- Only start if we found a valid root
        if root_dir then
            -- Check for conflicting system clients and detach them from this buffer
            local conflict_client = vim.lsp.get_clients({ name = "pyright", bufnr = 0 })[1]
            if conflict_client then
                vim.lsp.buf_detach_client(0, conflict_client.id)
            end
            vim.cmd('LspStop pyright')

            local cmd_str = string.format(
                "cd /ws && source /opt/ros/*/setup.bash && export PYTHONPATH=$PYTHONPATH:. && pyright-langserver --stdio",
                root_dir
            )

            local client_id = vim.lsp.start({
                name = "docker_ros_pyright",

                -- The Command
                cmd = { 
                    "docker", "compose", "exec", 
                    "-T",       -- No TTY
                    "-i",       -- Interactive (Keep Stdin open!)
                    "ros",      -- Service Name
                    -- "pyright-langserver", "--stdio" 
                    "bash", "-c", -- Wrap in bash to allow sourcing
                    -- Note: We use a wildcard (*) for the distro so it works on humble/iron/jazzy automatically
                    cmd_str
                },
                --
                -- fixes issue with lang server being killed
                before_init = function(params)
                    params.processId = nil--vim.NIL
                end,

                -- The Environment (Fixes the socket issue)
                cmd_env = {
                    DOCKER_HOST = "unix://" .. os.getenv("HOME") .. "/.orbstack/run/docker.sock",
                    PATH = vim.env.PATH,
                },

                root_dir = root_dir,

                -- Settings
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "openFilesOnly",
                        },
                    },
                },

                -- Capabilities (Hook into nvim-cmp if you use it)
                -- capabilities = require('cmp_nvim_lsp').default_capabilities(),

                -- Fix for Docker PID issue
                on_new_config = function(new_config, new_root_dir)
                    new_config.processId = vim.NIL
                end,
            })

            -- Optional: Notify if it attached successfully
            -- if client_id then vim.notify("Docker LSP Attached") end
        end
    end,
})

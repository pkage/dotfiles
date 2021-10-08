--[[

LSP configuration

refer to https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

--]]

-- Lua
-- sumneko is a pain, i'll do this later

-- Python
require'lspconfig'.pyright.setup{}
-- npm i -g pyright


-- Javascript
require'lspconfig'.tsserver.setup{}
-- npm i -g typescript typescript-language-server


-- html
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
    capabilities = capabilities,
}
-- npm i -g vscode-langservers-extracted


-- Rust
require'lspconfig'.rust_analyzer.setup{}
-- rustup +nightly component add rust-analyzer-preview



-- Svelte
require'lspconfig'.svelte.setup{}

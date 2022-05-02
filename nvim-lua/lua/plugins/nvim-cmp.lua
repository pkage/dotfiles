-- Setup nvim-cmp (from the docs)
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            -- For `luasnip` user.
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },

        -- For luasnip user.
        { name = 'luasnip' },

        -- { name = 'buffer' }, -- this is a bit annoying
    }
})

-- Setup lspconfig at some point...
--require('lspconfig')[%YOUR_LSP_SERVER%].setup {
--    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--}

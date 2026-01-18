require "nvchad.autocmds"



vim.api.nvim_create_autocmd('FileType', {
  -- pattern = "python",
  callback = function()
    pcall(function() vim.treesitter.start() end) -- always try to start treesitter
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'svelte',
  callback = function()
      vim.o.syntax = 'html'
  end
})

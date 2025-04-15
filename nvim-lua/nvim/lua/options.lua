require "nvchad.options"

-- add yours here!

local o = vim.o
local g = vim.g

-- enable cursorline
o.cursorlineopt ='both'

-- separate vim and system clipboards
o.clipboard = ''

g.multi_cursor_use_default_mapping=0
g.multi_cursor_next_key = '<C-b>'
g.multi_cursor_prev_key = '<C-p>'
g.multi_cursor_skip_key = '<C-x>'
g.multi_cursor_quit_key = '<Esc>'

-- tab stuff
o.tabstop=4
o.shiftwidth=4
o.expandtab = true

-- filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ejs",
  callback = function()
    vim.bo.syntax   = "html"
    vim.bo.filetype = "html"
  end,
})

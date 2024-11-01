require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- hop stuff
local hop = require('hop')
local directions = require('hop.hint').HintDirection
map('', '<leader><leader>w', function()
  hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, {remap=true, desc="Hop by word forwards"})
map('', '<leader><leader>b', function()
  hop.hint_words({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, {remap=true, desc="Hop by word backwards"})

-- multiple cursors
map("n", "<C-b>", ':call multiple_cursors#new("n", 0)<CR>', {remap=true, desc="Start multiple cursors"})


-- easyalign
map("n", "ga", "<Plug>(EasyAlign)", {desc="EasyAlign hook (normal mode)"})
map("x", "ga", "<Plug>(EasyAlign)", {desc="EasyAlign hook (x mode)"})

-- other quality of life
map({ "n", "t" }, "<C-y>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })

map("n", "<leader>'", "V:s/\"/'/g<cr>:noh<cr>", {desc="replace double quotes"})
map("n", "<leader>;", "V:s/;//g<cr>:noh<cr>", {desc="remove semicolons"})

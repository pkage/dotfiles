require('lualine').setup({
    options = {
        -- theme = 'moonfly',
        icons_enabled = false,
        component_separators = {'', ''},
        section_separators   = {'', ''}
        -- component_separators = {'', ''},
        -- section_separators = {'', ''},
    },
    sections = {
        lualine_a = {{'mode', lower=true}},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress',},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },

    extensions = {
        'nvim-tree'
    }
})


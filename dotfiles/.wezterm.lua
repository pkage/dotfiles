local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.audible_bell = 'Disabled'

return config

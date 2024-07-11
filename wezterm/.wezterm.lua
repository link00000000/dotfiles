local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { "nu.exe" }
config.color_scheme = "Tokyo Night"
config.font = wezterm.font("Iosevka Custom")

return config

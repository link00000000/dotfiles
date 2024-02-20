---@type PluginModule
local M = {
    spec = {
        require("plugins.colorschemes.base16").spec,
        require("plugins.colorschemes.catppuccino").spec,
        require("plugins.colorschemes.codedark").spec,
        require("plugins.colorschemes.dogrun").spec,
        require("plugins.colorschemes.dracula").spec,
        require("plugins.colorschemes.monokai").spec,
        require("plugins.colorschemes.nightfox").spec,
        require("plugins.colorschemes.nord").spec,
        require("plugins.colorschemes.oceanic-next").spec,
        require("plugins.colorschemes.onedarker").spec,
        require("plugins.colorschemes.srcery").spec,
        require("plugins.colorschemes.toast").spec,
        require("plugins.colorschemes.tokyonight").spec,
        require("plugins.colorschemes.vscode").spec,
    },
    set_colorscheme = function ()
        vim.cmd.colorscheme("carbonfox")
    end
}

return M

---@type PluginModule
return {
    spec = {
        "folke/tokyonight.nvim",
        config = function ()
            require("tokyonight").setup({
                on_highlights = function(hl, colors)
                    hl.FloatBorder = { link = "NormalFloat" }
                    hl.FloatTitle = { link = "NormalFloat" }

                    hl.TelescopeBorder = { link = "NormalFloat" }
                    hl.TelescopePromptTitle = { fg = colors.bg, bg = colors.blue }
                    hl.TelescopeResultsTitle = { fg = colors.bg, bg = colors.blue5 }
                    hl.TelescopePreviewTitle = { fg = colors.bg, bg = colors.magenta }
                end,
            })

            vim.cmd([[colorscheme tokyonight-night]])
        end
    }
}

---@type PluginModule
return {
    spec = {
        "petertriho/nvim-scrollbar",
        enable = false,
        config = function ()
            require("scrollbar").setup({
                excluded_filetypes = {
                    "cmp_docs",
                    "cmp_menu",
                    "noice",
                    "prompt",
                    "TelescopePrompt",
                    "alpha",
                    "NvimTree",
                },
                handlers = {
                    cursor = true,
                    diagnostic = true,
                    gitsigns = true,
                    handle = true,
                    search = true,
                }
            })
        end,
        dependencies = {
            require("plugins.gitsigns").spec,
            require("plugins.nvim-hlslens").spec,
        }
    }
}

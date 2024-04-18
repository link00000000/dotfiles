---@type PluginModule
return {
    spec = {
        "kndndrj/nvim-projector",
        config = function ()
            require("projector").setup({
                loaders = {
                    require("projector.loaders").BuiltinLoader:new(),
                    require("projector.loaders").DapLoader:new(),
                    require("projector_vscode").LaunchJsonLoader:new(),
                    require("projector_vscode").TasksJsonLoader:new(),
                },
                outputs = {
                    require("projector.outputs").TaskOutputBuilder:new(),
                    require("projector.outputs").DapOutputBuilder:new(),
                },
            })

            vim.keymap.set("n", "<Leader>dpr", function () require("projector").toggle() end, { desc = "Restart current Projector task" })
            vim.keymap.set("n", "<Leader>dpk", function () require("projector").toggle() end, { desc = "Kill current Projector task" })
        end,
        dependencies = {
            require("plugins.nui").spec,
            "kndndrj/projector-vscode",
        },
    },
}

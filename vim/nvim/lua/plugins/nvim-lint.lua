---@type PluginModule
return {
    spec = {
        "mfussenegger/nvim-lint",
        lazy = false,
        event = { "BufEnter" },
        init = function (self)
            require("lint").linters_by_ft = {}
        end
    }
}

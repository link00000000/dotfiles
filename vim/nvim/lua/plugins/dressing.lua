---@class TestClass
---@field Test string

---@type TestClass
local x = {}

---@type PluginModule
return {
    spec = {
        "stevearc/dressing.nvim",
        config = function ()
            require("dressing").setup({})
        end
    }
}

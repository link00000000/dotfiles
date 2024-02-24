local function config ()
    require("mason-nvim-lint").setup({
        ensure_installed = {},
        automatic_installation = true,
    })
end

---@type PluginModule
return {
    spec = {
        "rshkarin/mason-nvim-lint",
        lazy = false,
        config = config,
        dependencies = {
            require("plugins.mason").spec,
            require("plugins.nvim-lint").spec,
        }
    }
}

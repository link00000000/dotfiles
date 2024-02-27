local function config ()
    require("mason-null-ls").setup({
        handlers = {
            ["taplo"] = function () --[[Intentionally disable taplo support since taplo has native LSP support handled by lspconfig]] end
        },
    })
end

---@type PluginModule
return {
    spec = {
        "jay-babu/mason-null-ls.nvim",
        config = config,
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            require("plugins.mason").spec,
            require("plugins.none-ls").spec,
        },
    },
}

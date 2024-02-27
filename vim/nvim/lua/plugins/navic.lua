---@type lsp.OnAttach
local function on_attach (client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end
end

---@type PluginModule
return {
    on_attach = on_attach,
    spec = {
        'SmiteshP/nvim-navic',
        lazy = true,
    }
}

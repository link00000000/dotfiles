---@type lsp.OnAttach
local on_attach = function (client, bufnr)
    if client.server_capabilities.foldingRangeProvider then
        require("folding").on_attach()
    end
end

local function config ()
end

---@type PluginModule
return {
    spec = {
        'pierreglaser/folding-nvim',
        lazy = true,
        config = config,
    },
    on_attach = on_attach
}

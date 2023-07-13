local M = {}

local function config ()
    local luasnip_vscode_loader = require("luasnip.loaders.from_vscode")
    luasnip_vscode_loader.lazy_load() -- TODO: Add custom path for custom snippets? Make sure this doesn't break friendly-snippets
end

M.spec = {
    'L3MON4D3/LuaSnip',
    lazy = true,
    config = config,
    dependencies = {
        require("plugins.friendly-snippets").spec
    },
    event = { "BufEnter" }
}

return M

---@type PluginModule
return {
    spec = {
        "mg979/vim-visual-multi",
        init = function ()
            vim.g.VM_default_mappings = false;
        end
    }
}

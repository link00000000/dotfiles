---@type PluginModule
return {
    spec = {
        "subnut/nvim-ghost.nvim",
        lazy = false,
        config = function ()
            vim.api.nvim_create_user_command("Ghost", function ()
                vim.cmd([[GhostTextStart]])
            end, { bang = true })
        end
    }
}

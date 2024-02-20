---@type { [string]: string }
local group_labels = {}

local function config ()
    local whichkey = require("which-key")
    whichkey.setup({})
end

---Add label to group. If that group already has a label, then append it
---@param keymap string
---@param label string
local function add_group_label (keymap, label)
    if group_labels[keymap] == nil then
        group_labels[keymap] = label
    else
        group_labels[keymap] = group_labels[keymap] .. "/" .. label
    end

    require("which-key").register({ name = group_labels[keymap] })
end

---@type PluginModule
return {
    spec = {
        "folke/which-key.nvim",
        event = "VeryLazy",
        lazy = true,
        config = config,
        keys = { "<Leader>" },
        cmd = { "WhichKey" }
    },
    add_group_label = add_group_label
}

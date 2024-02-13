local keymap = require("utils.keymap")
local command = require("utils.command")

---@type PluginModule
local M = { spec = {} }

local function config ()
    command.create("ToggleVenn", M.toggle_venn)
end

function M.toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then

        ---@diagnostic disable-next-line: inject-field
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]

        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})

        -- draw a box by pressing "b" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "b", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.cmd[[mapclear <buffer>]]
        ---@diagnostic disable-next-line: inject-field
        vim.b.venn_enabled = nil
    end
end

M.spec = {
    "jbyuki/venn.nvim",
    lazy = true,
    config = config,
    keys = {
        keymap.normal.lazy("<Leader>vt", M.toggle_venn, { desc = "Toggle venn" })
    },
    cmd = { "ToggleVenn", "VBox" },
}

return M

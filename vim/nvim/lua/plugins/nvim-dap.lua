local M = {}

local function config ()
end

M.spec = {
    "mfussenegger/nvim-dap",
    lazy = true,
    config = config,
    event = { "BufEnter" },
    dependencies = {
        require("plugins.mason-nvim-dap").spec,
    }
}

return M

local M = {}

local function config ()
    local mason_nvim_dap = require("mason-nvim-dap")
    mason_nvim_dap.setup({
        handlers = {
            require("plugins.dap.generic").setup_handler,
        }
    })
end

M.spec = {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = true,
    config = config,
    dependencies = {
        require("plugins.nvim-dap").spec,
        require("plugins.mason").spec,
    }
}

return M

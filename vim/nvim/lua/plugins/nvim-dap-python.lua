local M = {}

M.spec = {
    "mfussenegger/nvim-dap-python",
    lazy = true,
    ft = "python",
    dependencies = {
        require("plugins.nvim-dap").spec
    },
    config = function ()
        local path = require("utils.path")
        local dap_python = require("dap-python")

        dap_python.setup(path.get_nvim_data_dir("mason/packages/debugpy/venv/Scripts/python"))
    end
}

return M

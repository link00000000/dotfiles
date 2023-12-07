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

        dap_python.setup(path.resolve_nvim_data_dir_path("mason/packages/debugpy/venv/Scripts/python"))
    end
}

return M

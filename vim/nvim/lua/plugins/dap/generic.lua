local M = {}

M.setup_handler = function (config)
    -- NOTE: This should be last for *all* configurations
    require("mason-nvim-dap").default_setup(config)
end

return M

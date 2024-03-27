---@class DAP
---@field setup_handler fun(config: table)

---@param setup fun(config: table)|nil
local function create_setup_handler (setup)
    return function (config)
        if setup ~= nil then
            setup(config)
        end

        require("mason-nvim-dap").default_setup(config)
    end
end

---@type DAP
return {
    create_setup_handler = create_setup_handler,
    setup_handler = create_setup_handler()
}

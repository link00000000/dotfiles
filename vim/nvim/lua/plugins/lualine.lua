
local config = function ()
    local lualine = require("lualine")
    local codicons = require("codicons")
    
    local get_dap = function ()
        local success, module = pcall(function ()
            return require("dap")
        end)

        if success then
            return module
        else
            return nil
        end
    end

    local is_dap_running = function ()
        local dap = get_dap()
        if dap == nil then
            return false
        end

        local dap_status = require("dap").status()
        return dap_status ~= nil and string.len(dap_status) > 0
    end

    ---@param running_icon { icon_name: string, color: string }
    ---@param not_running_icon { icon_name: string, color: string }
    ---@param on_click function
    local create_dap_component = function (running_icon, not_running_icon, on_click)
        return {
            function ()
                if is_dap_running() then
                    return codicons.get(running_icon.icon_name, "icon");
                end
                if (condition == "running" and is_dap_running()) or (condition == "not-running" and not is_dap_running()) then
                    return codicons.get(icon, "icon")
                else
                    return ""
                end
            end,

            color = color,

            ---@param num_clicks number
            ---@param mouse_button "l"|"r"|"m"
            on_click = function (num_clicks, mouse_button)
                if (mouse_button == "l") then
                    on_click()
                end
            end,
        }
    end

    local current_time_component = function ()
        return vim.fn.strftime('%I:%M:%S %p')
    end

    lualine.setup({
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename', 'filetype', 'lsp_progress' },
            lualine_x = { current_time_component },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
        tabline = {
            lualine_a = { "tabs" },
            lualine_b = { },
            lualine_c = { },
            lualine_x = {
                create_dap_component("not-running", "play", "DapUIPlayPause", function () require("dap").continue() end),
                create_dap_component("running", "debug-continue", "DapUIPlayPause", function () require("dap").continue() end),
                create_dap_component("running", "debug-step-over", "DapUIStepOver", function () require("dap").step_over() end),
                create_dap_component("running", "debug-step-into", "DapUIStepInto", function () require("dap").step_into() end),
                create_dap_component("running", "debug-step-out", "DapUIStepOut", function () require("dap").step_out() end),
                create_dap_component("running", "debug-restart", "DapUIRestart", function () require("dap").restart() end),
                create_dap_component("running", "debug-stop", "DapUIStop", function () require("dap").close() end),
            },
            lualine_y = { },
            lualine_z = { },
        },
        options = {
            theme = "auto",
            section_separators = { left = "", right = "" },
            component_separators = { left = "", right = "" },
        },
        extensions = {
            "nvim-dap-ui",
            "trouble",
            "quickfix",
        },
    })
end

---@type PluginModule
return {
    spec = {
        'nvim-lualine/lualine.nvim',
        lazy = true,
        config = config,
        dependencies = {
            require('plugins.nvim-web-devicons').spec,
            require('plugins.lualine-lsp-progress').spec,
            require("plugins.codicons").spec,
        },
        event = { 'BufEnter' },
    }
}

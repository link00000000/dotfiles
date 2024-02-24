local current_time = function ()
    return vim.fn.strftime('%I:%M:%S %p')
end

local config = function ()
    local lualine = require('lualine')

    lualine.setup({
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename', 'lsp_progress' },
            lualine_x = { current_time, 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
        options = {
            theme = "auto",
            section_separators = { left = "", right = "" },
            component_separators = { left = "", right = "" },
        }
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
        },
        event = { 'BufEnter' }
    }
}

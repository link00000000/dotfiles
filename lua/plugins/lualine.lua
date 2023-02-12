local current_time = function ()
    return vim.fn.strftime('%I:%M:%S %p')
end

local config = function ()
    local lualine = require('lualine')

    lualine.setup({
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { current_time, 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
    })
end

return {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    config = config,
    dependencies = {
        require('plugins.nvim-web-devicons')
    }
}

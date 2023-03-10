local M = {}

local function config ()
    local nvim_web_devicons = require('nvim-web-devicons')

    nvim_web_devicons.setup({
        override = {
            Makefile = {
                icon = "",
                color = "#428850",
                name = "Makefile",
            },
            sql = {
                icon = "",
                color = "#cbcb41",
                name = "sql",
            },
            cs = {
                icon = "",
                color = "#019833",
                name = "Cs",
            },
            sln = {
                icon = "",
                color = "#e37933",
                name = "Sln",
            },
            csproj = {
                icon = "",
                color = "#7160e8",
                name = "Csproj",
            },
        },
    })
end

M.spec = {
    'kyazdani42/nvim-web-devicons',
    lazy = true,
    config = config,
}

return M

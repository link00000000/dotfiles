local M = {}

local function config ()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({})
    -- TODO: Setup cmp
end

M.spec = {
    "windwp/nvim-autopairs",
    lazy = true,
    config = config,
    event = "InsertEnter"
}

return M

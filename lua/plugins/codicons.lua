local function config ()
    local codicons = require('codicons')
    codicons.setup()
end

return {
    'mortepau/codicons.nvim',
    lazy = false,
    config = config,
}

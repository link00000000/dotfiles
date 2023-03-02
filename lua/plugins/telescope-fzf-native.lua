local M = {}

local function config ()
    -- TODO:
end

M.spec = {
    'link00000000/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    lazy = false,
    config = config,
}

return M

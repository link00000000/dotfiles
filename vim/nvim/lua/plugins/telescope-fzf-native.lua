local M = {}

local function config ()
end

M.spec = {
    'link00000000/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    lazy = true,
    config = config,
}

return M

local M = {}

---@enum os
M.OS = {
    windows = "Windows_NT",
}

---@return os
M.get_os = function ()
    local sysname = vim.loop.os_uname().sysname;
    if sysname == M.OS.windows then
        return M.OS.windows
    end

    error("Unknown OS " .. sysname)
end

return M

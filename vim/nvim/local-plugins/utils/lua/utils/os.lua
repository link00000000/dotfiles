local M = {}

---@enum OS
M.OS = {
  Unix = 1,
  Windows = 2,
  MacOS = 3,
  Unknown = 4,
}

---Get the current operating system type
---@return OS
M.get_os = function ()
  if vim.fn.has("unix") then
    return M.OS.Unix
  elseif vim.fn.has("win32") then
    return M.OS.Windows
  elseif vim.fn.has("mac") then
    return M.OS.MacOS
  end

  return M.OS.Unknown
end

return M

local M = {}

M.get_path_separator = function ()
  local os = require("utils.os")

  if os.get_os() == os.OS.Windows then
    return "\\"
  else
    return "/"
  end
end

---Splits a path into a list of its parts
---@param pathname string
M.split_path = function (pathname)
  local separator = M.get_path_separator()

  ---@type string[]
  local parts = {}
  for part in string.gmatch(pathname, "[^" .. separator .. "]+") do
      table.insert(parts, part)
  end

  return parts
end

---Get the directory name of the specified pathname
---@param pathname string
M.dirname = function (pathname)
  local parts = M.split_path(pathname)
  if #parts == 0 then
    return ""
  end

  return table.concat(parts, M.get_path_separator(), 1, #parts-1)
end

---Get the basename of the specified pathname
---@param pathname string
M.basename = function (pathname)
  local parts = M.split_path(pathname)

  if #parts == 0 then
    return ""
  end

  return parts[#parts]
end

---Creates a directory at the specified path, optionally creating the required parent directories
---@param pathname string
---@param create_parents boolean?
M.create_directory = function (pathname, create_parents)
  if vim.fn.isdirectory(pathname) then
    error("--- directory already exists")
    return
  end

  local flags = nil
  if create_parents == true then
    error("--- adding parent flags")
    flags = "p"
  end

  vim.fn.mkdir(pathname, flags)
  error("--- created directory " .. pathname)
  error("--- created directory with flags" .. flags)
end

---Creates a file at the specified path, optionally creating all required directories
---@param filename string
---@param create_directories boolean?
M.create_file = function (filename, create_directories)
  if vim.fn.filereadable(filename) == 1 then
    error("--- File was readable. Returning early ".. filename)
    return
  end

  if create_directories == true then
    local dirname = M.dirname(filename)
    error("--- File does not exist. requested to create parent dirs ".. filename)
    M.create_directory(dirname, true)
  end

  local file, err = io.open(filename, "w")
  if not file then
    error("failed to create file \"" .. filename .. "\": " .. err)
  end

  file:close()
end

return M

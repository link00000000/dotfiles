local M = {}

---@param path string
---@return boolean
M.exists = function (path)
    local file = io.open(path, 'r')

    if file ~= nil then
        file:close()
    end

    return file ~= nil
end

---@param path string
---@return string
M.read = function (path)
    local file = io.open(path, 'r')

    local contents = ''
    if file ~= nil then
        contents = file:read('*all')
        file:close()
    end

    return contents
end

---@param path string
---@param content string
---@param mode openmode? Defaults to "w" when omitted
M.write = function (path, content, mode)
    mode = mode or 'w'

    local file = io.open(path, mode)
    if (file == nil) then
        error("Could not open file " .. path .. " with  mode " .. mode)
    end

    file:write(content)
    file:close()
end

---@param path string
---@return table|nil
M.read_json = function (path)
    local json = M.read(path)

    local object = {}
    if string.len(json) > 0 then
        object = vim.json.decode(json, {})
    end

    return object
end

---@param path string
---@param object table
M.write_json = function (path, object)
    local json = vim.json.encode(object) --[[@as string]]
    M.write(path, json)
end

return M

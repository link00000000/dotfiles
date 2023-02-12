local M = {}

M.exists = function (path)
    local file = io.open(path, 'r')

    if file ~= nil then
        file:close()
    end

    return file ~= nil
end

M.read = function (path)
    local file = io.open(path, 'r')

    local contents = ''
    if file ~= nil then
        contents = file:read('*all')
        file:close()
    end

    return contents
end

M.write = function (path, contents)
    local file = io.open(path, 'w')
    file:write(contents)

    file:close()
end

M.read_json = function (path)
    local json = M.read(path)

    local object = {}
    if string.len(json) > 0 then
        object = vim.json.decode(json)
    end

    return object
end

M.write_json = function (path, object)
    local json = vim.json.encode(object)
    M.write(path, json)
end

return M

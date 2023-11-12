local M = {}

---@param s string
---@param opts { type: "single"|"double" }
function M.escape_quotes (s, opts)
    local quote

    if opts ~= nil and opts.type == 'single' then
        quote = '\''
    elseif opts ~= nil and opts.type == 'double' then
        quote = '"'
    else
        error("opts.type must be either 'single' or 'double'")
    end

    s = s:gsub(quote, '\\' .. quote)
    return s
end

---@param path string
---@param opts { shell_x_quote: vim.opt.shellxquote?, shell_cmd_flag: vim.opt.shellcmdflag?, shell_quote: vim.opt.shellquote?, shell_pipe: vim.opt.shellpipe?, shell_redir: vim.opt.shellredir? }?
M.set = function (path, opts)
    vim.opt.shell = path

    if opts ~= nil then
        if opts.shell_x_quote ~= nil then
            vim.opt.shellxquote = opts.shell_x_quote
        end

        if opts.shell_cmd_flag ~= nil then
            vim.cmd('let &shellcmdflag = \'' .. opts.shell_cmd_flag .. '\'')
        end

        if opts.shell_quote ~= nil then
            vim.cmd('let &shellquote = \'' .. opts.shell_quote .. '\'')
        end

        if opts.shell_pipe ~= nil then
            vim.cmd('let &shellpipe = \'' .. opts.shell_pipe .. '\'')
        end

        if opts.shell_redir ~= nil then
            vim.cmd('let &shellredir = \'' .. opts.shell_redir .. '\'')
        end
    end
end

---@param command string
M.build_command = function (command)
    local escaped_command = M.escape_quotes(command, { type = 'double' })
    return ':lua vim.fn.system("' .. escaped_command .. '")'
end

return M

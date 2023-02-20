local shell = require('utils.shell')

local M = {}

M.setup = function ()
    shell.set('pwsh.exe', {
        shell_x_quote = '',
        shell_cmd_flag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command ',
        shell_quote = '',
        shell_pipe = '| Out-File -Encoding UTF8 %s',
        shell_redir = '| Out-File -Encoding UTF8 %s',
    })
end

return M

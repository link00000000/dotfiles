local shell = require('utils.shell')

---@type ConfigModule
return {
    setup = function ()
        shell.set('nu.exe', {
            shell_x_quote = '',
            shell_cmd_flag = '--commands ',
            shell_quote = '',
            shell_pipe = '',
            shell_redir = '',
        })
    end
}

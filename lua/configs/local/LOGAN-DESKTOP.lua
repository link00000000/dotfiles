local M = {}

M.setup = function ()
    vim.opt.shell = 'pwsh.exe'
    vim.opt.shellxquote = ''

    vim.cmd([[

    let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
    let &shellquote   = ''
    let &shellpipe    = '| Out-File -Encoding UTF8 %s'
    let &shellredir   = '| Out-File -Encoding UTF8 %s'

    ]])
end

return M

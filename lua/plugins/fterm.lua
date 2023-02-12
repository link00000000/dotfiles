local keymap = require('utils.keymap')
local command = require('utils.command')

local function new_shell_term ()
    local fterm = require('FTerm')

    local shell_term = fterm:new({
        ft = 'FTerm_shell',
        cmd = vim.opt.shell:get() or os.getenv("SHELL") or "powershell.exe",
        blend = 10,
    })

    return shell_term
end

local function new_git_term ()
    local fterm = require('FTerm')

    local git_term = fterm:new({
        ft = 'FTerm_git',
        cmd = 'lazygit',
        blend = 10,
    })

    return git_term
end

local function new_mprocs_term ()
    local fterm = require('FTerm')

    local mprocs_term = fterm:new({
        ft = 'FTerm_mprocs',
        cmd = 'mprocs',
        blend = 10,
    })

    return mprocs_term
end

local function new_glow_scratch ()
    local fterm = require('FTerm')

    local file_name = vim.api.nvim_buf_get_name(0)
    fterm.scratch({ cmd = 'glow --pager ' .. file_name, auto_close = true, blend = 10 })
end

local function new_chtsh_scratch (context)
    local fterm = require('FTerm')

    local args = context.args

    local file_name = vim.api.nvim_buf_get_name(0)
    fterm.scratch({ cmd = 'curl -Ls cht.sh/' .. args, auto_close = true, blend = 10 })
end

local function close_focused (terms)
    local ft = vim.bo.filetype
    local term = terms[ft]
    
    if term ~= nil then
        term:close()
    end
end

local function config ()
    local shell_term = new_shell_term()
    command.create('FTermOpen', function () shell_term:open() end)
    command.create('FTermClose', function () shell_term:close() end)
    command.create('FTermExit', function () shell_term:close(true) end)
    command.create('FTermToggle', function () shell_term:toggle() end)

    local git_term = new_git_term()
    command.create('Git', function () git_term:toggle() end)
    command.create('GitClose', function () git_term:close() end)
    command.create('GitExit', function () git_term:close(true) end)
    command.create('GitToggle', function () git_term:toggle() end)

    local mprocs_term = new_mprocs_term()
    command.create('MProcs', function () mprocs_term:toggle() end)
    command.create('MProcsClose', function () mprocs_term:close() end)
    command.create('MProcsExit', function () mprocs_term:close(true) end)
    command.create('MProcsToggle', function () mprocs_term:toggle() end)

    command.create('Glow', new_glow_scratch)
    command.create('Cht', new_chtsh_scratch, { nargs = '?' })

    local terms = {
        ['FTerm_shell'] = shell_term,
        ['FTerm_git'] = git_term,
        ['FTerm_mprocs'] = mprocs_term,
    }
    command.create('FTermCloseFocused', function () close_focused(terms) end)
end

return {
    'numtostr/FTerm.nvim',
    lazy = true,
    config = config,
    keys = {
        keymap.normal('`', '<cmd>FTermToggle<CR>', { 'Toggle terminal' }).lazy,
        keymap.normal('<Leader>gg', '<cmd>Git<CR>', { 'Toggle Git' }).lazy,
        keymap.normal('<F5>', '<cmd>MProcs<CR>', { 'Toggle MProcs' }).lazy,
        keymap.terminal('<F5>', '<cmd>MProcs<CR>', { 'Toggle MProcs' }).lazy,
    },
    cmd = {
        'FTermOpen', 'FTermClose', 'FTermExit', 'FTermToggle',
        'Git', 'GitClose', 'GitExit', 'GitToggle',
        'MProcs', 'MProcsClose', 'MProcsExit', 'MProcsToggle',
        'Glow', 'Cht',
        'FTermCloseFocused',
    }
}

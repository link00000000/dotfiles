local keymap = require('utils.keymap')
local command = require('utils.command')

local M = {}

M.terms = {}

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
    fterm.scratch({ cmd = 'curl -Ls cht.sh/' .. args, auto_close = true, blend = 10 })
end

local function get_term_by_filetype (ft)
    local terms = {
        ['FTerm_shell'] = M.terms.shell,
        ['FTerm_git'] = M.terms.git,
        ['FTerm_mprocs'] = M.terms.mprocs,
    }

    return terms[ft]
end

M.close_focused = function ()
    local ft = vim.bo.filetype
    local term = get_term_by_filetype(ft)

    if term ~= nil then
        term:close()
    end
end

M.setup_ftplugin = function ()
    vim.bo.sidescrolloff = 0

    keymap.terminal.apply('<Esc>', M.close_focused, { buffer = 0 })
end

local function config ()
    M.terms = {
        shell = new_shell_term(),
        git = new_git_term(),
        mprocs = new_mprocs_term(),
    }

    command.create('FTermOpen', function () M.terms.shell:open() end)
    command.create('FTermClose', function () M.terms.shell:close() end)
    command.create('FTermExit', function () M.terms.shell:close(true) end)
    command.create('FTermToggle', function () M.terms.shell:toggle() end)

    command.create('Git', function () M.terms.git:toggle() end)
    command.create('GitClose', function () M.terms.git:close() end)
    command.create('GitExit', function () M.terms.git:close(true) end)
    command.create('GitToggle', function () M.terms.git:toggle() end)

    command.create('MProcs', function () M.terms.mprocs:toggle() end)
    command.create('MProcsClose', function () M.terms.mprocs:close() end)
    command.create('MProcsExit', function () M.terms.mprocs:close(true) end)
    command.create('MProcsToggle', function () M.terms.mprocs:toggle() end)

    command.create('Glow', new_glow_scratch)
    command.create('Cht', new_chtsh_scratch, { nargs = '?' })

    command.create('FTermCloseFocused', function () M.close_focused() end)
end

M.spec = {
    'numtostr/FTerm.nvim',
    lazy = true,
    config = config,
    keys = {
        keymap.normal.lazy('`', '<cmd>FTermToggle<CR>', { desc = 'Toggle terminal' }),
        keymap.normal.lazy('<Leader>gg', '<cmd>Git<CR>', { desc = 'Toggle Git' }),
        keymap.normal.lazy('<F5>', '<cmd>MProcs<CR>', { desc = 'Toggle MProcs' }),
        keymap.terminal.lazy('<F5>', '<cmd>MProcs<CR>', { desc = 'Toggle MProcs' }),
    },
    cmd = {
        'FTermOpen', 'FTermClose', 'FTermExit', 'FTermToggle',
        'Git', 'GitClose', 'GitExit', 'GitToggle',
        'MProcs', 'MProcsClose', 'MProcsExit', 'MProcsToggle',
        'Glow', 'Cht',
        'FTermCloseFocused',
    }
}

return M

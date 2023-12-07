local keymap = require('utils.keymap')
local command = require('utils.command')

---@type { shell: Term, git: Term, mprocs: Term }?
local terms = nil

local function new_shell_term ()
    local fterm = require('FTerm')

    ---@diagnostic disable-next-line Settings are optional but not specified as such
    local shell_term = fterm:new({
        ft = 'FTerm_shell',
        cmd = vim.opt.shell:get() or os.getenv("SHELL") or "powershell.exe",
        blend = 10,
    })

    return shell_term
end

local function new_git_term ()
    local fterm = require('FTerm')

    ---@diagnostic disable-next-line Settings are optional but not specified as such
    local git_term = fterm:new({
        ft = 'FTerm_git',
        cmd = 'lazygit',
        blend = 10,
    })

    return git_term
end

local function new_mprocs_term ()
    local fterm = require('FTerm')

    ---@diagnostic disable-next-line Settings are optional but not specified as such
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

    ---@diagnostic disable-next-line Settings are optional but not specified as such
    fterm.scratch({ cmd = 'glow --pager ' .. file_name, auto_close = true, blend = 10 })
end

local function new_chtsh_scratch (context)
    local fterm = require('FTerm')

    ---@diagnostic disable-next-line Settings are optional but not specified as such
    fterm.scratch({ cmd = 'curl -Ls cht.sh/' .. context.args, auto_close = true, blend = 10 })
end

local function get_term_by_filetype (ft)
    if terms == nil then
        error("terms must be initialized from config() before accesssing")
    end

    return ({
        ['FTerm_shell'] = terms.shell,
        ['FTerm_git'] = terms.git,
        ['FTerm_mprocs'] = terms.mprocs,
    })[ft]
end

local close_focused_term = function ()
    local ft = vim.bo.filetype
    local term = get_term_by_filetype(ft)

    if term ~= nil then
        term:close()
    end
end

local setup_ftplugin = function ()
    vim.wo.sidescrolloff = 1

    keymap.terminal.apply('<Esc>', close_focused_term, { buffer = 0 })
end

local function config ()
    terms = {
        shell = new_shell_term(),
        git = new_git_term(),
        mprocs = new_mprocs_term(),
    }

    command.create('FTermOpen', function () terms.shell:open() end)
    command.create('FTermClose', function () terms.shell:close() end)
    command.create('FTermExit', function () terms.shell:close(true) end)
    command.create('FTermToggle', function () terms.shell:toggle() end)

    command.create('Git', function () terms.git:toggle() end)
    command.create('GitClose', function () terms.git:close() end)
    command.create('GitExit', function () terms.git:close(true) end)
    command.create('GitToggle', function () terms.git:toggle() end)

    command.create('MProcs', function () terms.mprocs:toggle() end)
    command.create('MProcsClose', function () terms.mprocs:close() end)
    command.create('MProcsExit', function () terms.mprocs:close(true) end)
    command.create('MProcsToggle', function () terms.mprocs:toggle() end)

    command.create('Glow', new_glow_scratch)
    command.create('Cht', new_chtsh_scratch, { nargs = '?' })

    command.create('FTermCloseFocused', function () close_focused_term() end)
end

---@type PluginModule
return {
    spec = {
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
    },
    setup_ftplugin = setup_ftplugin
}

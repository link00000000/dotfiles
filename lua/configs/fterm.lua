local fterm = require('FTerm')

-- Default shell
fterm.setup({
    cmd = vim.opt.shell:get() or os.getenv("SHELL") or "powershell.exe",
    blend = 10
})

local opts = { bang = true }
vim.api.nvim_create_user_command('FTermOpen', fterm.open, opts)
vim.api.nvim_create_user_command('FTermClose', fterm.close, opts)
vim.api.nvim_create_user_command('FTermExit', fterm.exit, opts)
vim.api.nvim_create_user_command('FTermToggle', fterm.toggle, opts)

vim.api.nvim_set_keymap('n', '`', '<cmd>FTermToggle<CR>', { silent = true })

-- Git

local git_term = fterm:new({
    ft = 'FTerm_git',
    cmd = 'lazygit',
    blend = 10
})

vim.api.nvim_create_user_command('Git',
    function ()
        git_term:toggle()
    end,
opts)

vim.api.nvim_create_user_command('GitClose',
    function ()
        git_term:close()
    end,
opts)

vim.api.nvim_create_user_command('GitExit',
    function ()
        git_term:exit()
    end,
opts)

vim.api.nvim_set_keymap('n', '<Leader>gg', '<cmd>Git<CR>', { silent = true })

-- MProcs

local mprocs_term = fterm:new({
    ft = 'FTerm_mprocs',
    cmd = 'mprocs',
    blend = 10
})

vim.api.nvim_create_user_command('MProcs',
    function ()
        mprocs_term:toggle()
    end,
opts)

vim.api.nvim_create_user_command('MProcsClose',
    function ()
        mprocs_term:close()
    end,
opts)

vim.api.nvim_create_user_command('MProcsExit',
    function ()
        mprocs_term:exit()
    end,
opts)

vim.api.nvim_set_keymap('n', '<F5>', '<cmd>MProcs<CR>', { silent = true })
vim.api.nvim_set_keymap('t', '<F5>', '<cmd>MProcs<CR>', { silent = true })

-- Glow

vim.api.nvim_create_user_command('Glow',
    function ()
        local file_name = vim.api.nvim_buf_get_name(0)
        fterm.scratch({ cmd = 'glow --pager ' .. file_name, auto_close = true, blend = 10 })
    end,
opts)

-- Cht.sh

vim.api.nvim_create_user_command('Cht',
    function (context)
        local args = context.args
        fterm.scratch({ cmd = 'curl -Ls cht.sh/' .. args, auto_close = true, blend = 10 })
    end,
{ bang = true, nargs='?' })

-- Commands

vim.api.nvim_create_user_command('FTermCloseFocused',
    function ()
        local ft = vim.bo.filetype

        if ft == "FTerm" then
            fterm.close()
        elseif ft == "FTerm_git" then
            git_term:close()
        elseif ft == "FTerm_mprocs" then
            mprocs_term:close()
        end
    end,
{})

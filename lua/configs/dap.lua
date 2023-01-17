local dap = require('dap')
local codicons = require('codicons')

dap.set_log_level('TRACE')

-- Signs

vim.fn.sign_define('DapBreakpoint', { text=codicons.get('circle-filled'), texthl='debug', linehl='', numhl='' })
vim.fn.sign_define('DapBreakpointCondition', { text=codicons.get('debug-breakpoint-conditional'), texthl='debug', linehl='', numhl='' })
vim.fn.sign_define('DapLogPoint', { text=codicons.get('debug-breakpoint-log'), texthl='debug', linehl='', numhl='' })
vim.fn.sign_define('DapBreakpointRejected', { text=codicons.get('circle'), texthl='debug', linehl='', numhl='' })


-- Keymaps

local opts = { silent = true, noremap = true }

vim.keymap.set('n', '<Leader>dc', dap.continue, opts)
vim.keymap.set('n', '<Leader>dn', dap.step_over, opts)
vim.keymap.set('n', '<Leader>di', dap.step_into, opts)
vim.keymap.set('n', '<Leader>do', dap.step_out, opts)
vim.keymap.set('n', '<Leader>dbb', dap.toggle_breakpoint, opts)
vim.keymap.set('n', '<Leader>dbc',
    function ()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end,
opts)
vim.keymap.set('n', '<Leader>dbl',
    function ()
        dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
    end,
opts)
vim.keymap.set('n', '<Leader>ds', dap.terminate, opts)
vim.keymap.set('n', '<Leader>dr', dap.restart, opts)
vim.keymap.set('n', '<Leader>dd', dap.repl.toggle, opts)


-- Adapters (https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation)

local mason_package = function (target_path)
    local data = vim.fn.stdpath('data')
    return data .. '/mason/packages/' .. target_path
end

-- Node

dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = { mason_package('node-debug2-adapter/out/src/nodeDebug.js') }
}

dap.configurations.javascript = {
    {
        name = 'Launch',
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
    },
    {
        -- For this to work you need to make sure the node process is started with the `--inspect` flag.
        name = 'Attach to process',
        type = 'node2',
        request = 'attach',
        processId = require'dap.utils'.pick_process,
    },
}

-- .NET

dap.adapters.coreclr = {
    type = 'executable',
    command = mason_package('netcoredbg/netcoredbg/netcoredbg.exe'),
    args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
    {
        type = 'coreclr',
        name = 'Launch',
        request = 'launch',
        program = function ()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end
    }
}


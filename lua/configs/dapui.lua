local dapui = require('dapui')
local dap = require('dap')

dapui.setup({
  icons = { expanded = "", collapsed = "", current_frame = "" },
})

-- Open and close dapui windows when debugging is started / stopped
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
    

local function key_action_toggle_breakpoint ()
  require("dap").toggle_breakpoint()
end

local function key_action_start_continue_debugging ()
  require("dap").continue()
end

local function key_action_stop_debugging ()
  require("dap").terminate()
end

local function key_action_step_over ()
  require("dap").step_over()
end

local function key_action_step_into ()
  require("dap").step_into()
end

local function key_action_step_out ()
  require("dap").step_out()
end

local function key_action_run_to_cursor ()
  require("dap").run_to_cursor()
end

local function key_action_toggle_conditional_breakpoint ()
  vim.ui.input({ prompt = "Condition: " }, function (cond)
    if condition then
      require("dap").set_breakpoint(cond)
    end
  end)
end

local function key_action_toggle_repl ()
  require("dap").repl.open()
end

return {
  "mfussenegger/nvim-dap",
  config = function ()
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    vim.api.nvim_set_hl(0, "DapBreakpoint", { default = true, link = "DiagnosticError" })
    vim.api.nvim_set_hl(0, "DapBreakpointRejected", { default = true, link = "DiagnosticUnnessessary" })

    vim.fn.sign_define("DapStopped",              { text = "󰁕 ", texthl = "DiagnosticWarn",         linehl = "DapStoppedLine",  numhl = nil })
    vim.fn.sign_define("DapBreakpoint",           { text = " ", texthl = "DapBreakpoint",          linehl = nil,               numhl = nil })
    vim.fn.sign_define("DapBreakpointCondition",  { text = " ", texthl = "DapBreakpoint",          linehl = nil,               numhl = nil })
    vim.fn.sign_define("DapBreakpointRejected",   { text = " ", texthl = "DapBreakpointRejected",  linehl = nil,               numhl = nil })
    vim.fn.sign_define("DapLogPoint",             { text = ".>", texthl = "DiagnosticInfo",         linehl = nil,               numhl = nil })

    require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "c", "cpp", "rust" } })
  end,
  keys = {
    { "<leader>dc", key_action_start_continue_debugging, desc = "Debugger: Start / continue" },
    { "<leader>dq", key_action_stop_debugging, desc = "Debugger: Stop" },
    { "<leader>dn", key_action_step_over, desc = "Debugger: Step over" },
    { "<leader>di", key_action_step_into, desc = "Debugger: Step into" },
    { "<leader>do", key_action_step_out, desc = "Debugger: Step out" },
    { "<leader>dh", key_action_run_to_cursor, desc = "Debugger: Run to cursor" },
    { "<leader>db", key_action_toggle_breakpoint, desc = "Debugger: Toggle breakpoint" },
    { "<leader>dC", key_action_toggle_conditional_breakpoint, desc = "Debugger: Conditional breakpoint" },
    { "<leader>dR", key_action_toggle_repl, desc = "Debugger: Toggle REPL" },
  },
  dependencies = {
    {
      "leoluz/nvim-dap-go",
      config = function ()
        require("dap-go").setup{}
      end,
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      config = function ()
        require("nvim-dap-virtual-text").setup{}
      end,
    }
  }
}

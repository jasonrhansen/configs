local dap = require("dap")
local dapui = require("dapui")
local telescope_dap = require('telescope').extensions.dap

dapui.setup()
require("telescope").load_extension("dap")
require("nvim-dap-virtual-text").setup()

-- Set up some listeners to automatically open and close dapui.
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local keymap_config = {
  {
    name = "DAP (Debug Adapter Protocol)",
    prefix = "",
    ["<F5>"] = { dap.continue, "Continue" },
    ["<F7>"] = { dap.step_into, "Step into" },
    ["<F8>"] = { dap.step_over, "Step over" },
    ["<F9>"] = { dap.step_out, "Step out" },
    ["<leader>b"] = { dap.toggle_breakpoint, "Toggle breakpoint" },
    ["<leader>B"] = { function () dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, "Set breakpoint" },
    ["<leader>r"] = { dap.repl_open, "Open REPL" },
  },
  {
    name = "DAP (Debug Adapter Protocol)",
    prefix = "<leader>td",
    ["c"] = { telescope_dap.commands, "DAP commands" },
    ["C"] = { telescope_dap.configurations, "DAP configurations" },
    ["b"] = { telescope_dap.list_breakpoints, "DAP breakpoints" },
    ["v"] = { telescope_dap.variables, "DAP variables" },
    ["f"] = { telescope_dap.frames, "DAP frames" },
  },
  {
    name = "DAP (Debug Adapter Protocol)",
    ["<leader>D"] = { dapui.toggle, "Toggle DAP UI" },
  },
}

for _, keymaps in ipairs(keymap_config) do
  -- Register keymaps with whick-key
  require("which-key").register(keymaps)
end

dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode-14",
  name = "lldb",
}

dap.configurations.rust = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
  {
    -- If you get an "Operation not permitted" error using this, try disabling YAMA:
    --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    name = "Attach to process",
    type = "lldb",
    request = "attach",
    pid = require("dap.utils").pick_process,
    args = {},
  },
}

dap.configurations.c = dap.configurations.rust
dap.configurations.cpp = dap.configurations.rust

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input("Host [127.0.0.1]: ")
      if value ~= "" then
        return value
      end
      return "127.0.0.1"
    end,
    port = function()
      local val = tonumber(vim.fn.input("Port: "))
      assert(val, "Please provide a port number")
      return val
    end,
  },
}

dap.adapters.nlua = function(callback, config)
  callback({ type = "server", host = config.host, port = config.port })
end

require("telescope").load_extension("dap")

-- Show virtual text for current frame
vim.g.dap_virtual_text = true

require("dapui").setup()

local keymap_config = {
  {
    name = "DAP (Debug Adapter Protocol)",
    cmd_prefix = "require'dap'",
    prefix = "",
    normal = {
      ["<F5>"] = { "continue()", "Continue" },
      ["<F7>"] = { "step_into()", "Step into" },
      ["<F8>"] = { "step_over()", "Step over" },
      ["<F9>"] = { "step_out()", "Step out" },
      ["<leader>b"] = { "toggle_breakpoint()", "Toggle breakpoint" },
      ["<leader>B"] = { "set_breakpoint(vim.fn.input('Breakpoint condition: ')", "Set breakpoint" },
      ["<leader>r"] = { "repl_open()", "Open REPL" },
    },
  },
  {
    name = "Telescope",
    cmd_prefix = "require'telescope'.extensions.dap",
    prefix = "<leader>t",
    normal = {
      ["dc"] = { "commands()", "DAP commands" },
      ["dC"] = { "configurations()", "DAP configurations" },
      ["db"] = { "list_breakpoints()", "DAP breakpoints" },
      ["dv"] = { "variables()", "DAP variables" },
      ["df"] = { "frames()", "DAP frames" },
    },
  },
  {
    name = "DAP (Debug Adapter Protocol)",
    cmd_prefix = "require'dapui'",
    prefix = "",
    normal = {
      ["<leader>D"] = { "toggle()", "Toggle DAP UI" },
    },
  },
}

for _, config in ipairs(keymap_config) do
  local keymaps = vim.tbl_map(function(keymap)
    return { "<cmd>lua " .. config.cmd_prefix .. "." .. keymap[1] .. "<cr>", keymap[2] }
  end, config.normal)

  keymaps.name = config.name

  -- Register keymaps with whick-key
  require("which-key").register(keymaps, { prefix = config.prefix })
end

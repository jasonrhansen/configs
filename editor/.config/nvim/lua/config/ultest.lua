vim.g.ultest_use_pty = 1

local keymap_config = {
  {
    prefix = "",
    normal = {
      ["]t"] = { "ultest-next-fail", "Jump to next failed test" },
      ["[t"] = { "ultest-prev-fail", "Jump to previous failed test" },
    },
  },
  {
    prefix = "<leader>u",
    normal = {
      ["f"] = { "ultest-run-file", "Run all tests in file" },
      ["n"] = { "ultest-run-nearest", "Run test closest to the cursor" },
      ["l"] = { "ultest-run-last", "Run tests that were last run" },
      ["s"] = { "ultest-summary-toggle", "Toggle test summary window" },
      ["j"] = { "ultest-summary-jump", "Jump to test summary window" },
      ["o"] = { "ultest-output-show", "Show error output of nearest test" },
      ["x"] = { "ultest-stop-file", "Stop all running tests fro current file" },
      ["d"] = { "ultest-debug-nearest", "Debug the nearest test with nvim-dap" },
    },
  },
}

for _, config in ipairs(keymap_config) do
  local keymaps = vim.tbl_map(function(keymap)
    return { "<Plug>(" .. keymap[1] .. ")", keymap[2] }
  end, config.normal)

  keymaps.name = 'ultest'

  -- Register keymaps with whick-key
  require("which-key").register(keymaps, { prefix = config.prefix })
end

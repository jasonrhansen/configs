require("plugins")

local lua_modules = {
  "config.options",
  "config.commands",
  "config.autocmds",
  "config.theme",
  "config.lsp",
  "config.telescope",
  "config.nvim_cmp",
  "config.window_picker",
  "config.neo_tree",
  "config.gitsigns",
  "config.treesitter",
  "config.treesitter_context",
  "config.trouble",
  "config.which_key",
  "config.keymaps",
  "config.lualine",
  "config.rust_tools",
  "config.crates",
  "config.dap",
  "config.comment",
  "config.luasnip",
  "config.nvim_retrail",
  "config.winbar",
  "config.indent_blankline",
  "config.nvim_osc52",
  "config.nvim_autopairs",
  "config.git_messenger",
}

for _, module_name in ipairs(lua_modules) do
  -- Remove cached module so config can be reloaded without restarting neovim
  package.loaded[module_name] = nil

  require(module_name)
end

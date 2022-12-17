local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

require("plugins")

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='

  require("packer").sync()

  -- When we are bootstrapping a configuration, it doesn't
  -- make sense to execute the rest of the init.lua.
  return
end


local lua_modules = {
  "config.globals",
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

local telescope = require 'telescope'
local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        -- Close with esc in insert mode.
        ["<esc>"] = actions.close,
      },
    },
    -- Color devicons slow it down too much for large projects.
    color_devicons = false,
  }
}

-- Manage trailing whitespace
local M = {
  "zakharykaplan/nvim-retrail",
}

function M.config()
  require("retrail").setup({
    -- Highlight group to use for trailing whitespace.
    hlgroup = "Search",
    -- Pattern to match trailing whitespace against. Edit with caution!
    pattern = "\\v((.*%#)@!|%#)\\s+$",
    -- Enabled filetypes.
    filetype = {
      -- Strictly enable only on `include`ed filetypes. When false, only disabled
      -- on an `exclude`ed filetype.
      strict = false,
      -- Included filetype list.
      include = {},
      -- Excluded filetype list. Overrides `include` list.
      exclude = {
        "",
        "alpha",
        "checkhealth",
        "diff",
        "help",
        "lazy",
        "lspinfo",
        "man",
        "mason",
        "gitmessengerpopup",
        "TelescopePrompt",
        "Trouble",
        "WhichKey",
      },
    },
    -- Trim on write behaviour.
    trim = {
      -- Trailing whitespace as highlighted.
      whitespace = true,
      -- Final blank (i.e. whitespace only) lines.
      blanklines = false,
    },
  })
end

return M

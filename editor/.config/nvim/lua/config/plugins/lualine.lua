local M = {
  "nvim-lualine/lualine.nvim",
}

function M.config()
  local lualine = require("lualine")
  local signs = require("config.signs")

  lualine.setup({
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "│", right = "│" },
      section_separators = "",
      globalstatus = true,
      disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(str)
            return " " .. str:sub(1, 1) .. " "
          end,
        },
      },
      lualine_b = { "branch" },
      lualine_c = { { "diagnostics", symbols = signs.diagnostic } },
      lualine_x = {
        { "searchcount", maxcount = 999, timeout = 500 },
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  })
end

return M

-- Status line
local M = {
  "hoob3rt/lualine.nvim",
}

function M.config()
  local lualine = require("lualine")

  local function lsp_status()
    return require("lsp-status").status()
  end

  local function git_status()
    return vim.b.gitsigns_status or ""
  end

  vim.cmd.colorscheme("kanagawa")
  local lualine_kanagawa = require("lualine.themes.kanagawa")
  lualine_kanagawa.normal.b.bg = "#3B4261"
  lualine_kanagawa.normal.c.bg = "#1F2335"

  lualine.setup({
    options = {
      icons_enabled = true,
      theme = lualine_kanagawa,
      component_separators = "",
      section_separators = { right = "", left = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", git_status },
      lualine_c = { lsp_status },
      lualine_x = {
        { "SleuthIndicator", fmt = string.upper },
        {
          "encoding",
          fmt = function(str)
            return str:gsub("utf", "UTF")
          end,
        },
        "fileformat",
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = { "fugitive", "nvim-tree", "quickfix" },
  })

  vim.go.laststatus = 3
end

return M

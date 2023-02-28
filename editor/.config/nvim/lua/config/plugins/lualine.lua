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

  lualine.setup({
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { "", "" },
      section_separators = { "", "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", git_status },
      lualine_c = {
        lsp_status,
        {
          require("noice").api.status.search.get,
          cond = require("noice").api.status.search.has,
          color = { fg = "#FFFFFF" },
        },
      },
      lualine_x = { "SleuthIndicator", "encoding", "fileformat", "filetype" },
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

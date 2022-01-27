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
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", git_status },
    lualine_c = { "filename", lsp_status },
    lualine_x = { "SleuthIndicator", "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "fugitive", "nvim-tree", "quickfix" },
})

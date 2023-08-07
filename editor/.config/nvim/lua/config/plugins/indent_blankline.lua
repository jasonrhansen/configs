-- Adds indentation guides to all lines (including empty lines).
local M = {
  "lukas-reineke/indent-blankline.nvim",
}

function M.config()
  require("indent_blankline").setup({
    char = "│",
    use_treesitter = true,
    use_treesitter_scope = false,
    show_first_indent_level = true,
    show_current_context = true,
    show_current_context_start = false,
    show_trailing_blankline_indent = false,
    filetype_exclude = { "help", "packer" },
    buftype_exclude = { "help", "terminal", "nofile" },
  })

  vim.g.indent_blankline_enabled = false
end

return M

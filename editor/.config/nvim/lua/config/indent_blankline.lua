require("indent_blankline").setup({
  char = "│",
  use_treesitter = true,
  show_first_indent_level = true,
  show_current_context = false,
  show_trailing_blankline_indent = false,
  filetype_exclude = { "help", "packer" },
  buftype_exclude = { "help", "terminal", "nofile" },
})

vim.g.indent_blankline_enabled = false
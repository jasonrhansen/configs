local treesitter = require("nvim-treesitter.configs")

treesitter.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    use_languagetree = true, -- For language injection (currently very unstable)
  },
  playground = {
    enable = true,
    updatetime = 25,
    persist_queries = false,
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "gnn",
  --     node_incremental = "grn",
  --     scope_incremental = "grc",
  --     node_decremental = "grm",
  --   },
  -- },
  -- textobjects = {
  --   select = {
  --     enable = true,
  --     keymaps = {
  --       ["af"] = "@function.outer",
  --       ["if"] = "@function.inner",
  --       ["ac"] = "@class.outer",
  --       ["ic"] = "@class.inner",
  --     },
  --   },
  --   lsp_interop = {
  --     enable = true,
  --     peek_definition_code = {
  --       ["df"] = "@function.outer",
  --       ["dF"] = "@class.outer",
  --     },
  --   },
  -- },
}

vim.api.nvim_set_keymap("", "<F8>", "<cmd>TSBufDisable highlight<CR>", {noremap=true, silent=true})
vim.api.nvim_set_keymap("", "<F9>", "<cmd>TSBufEnable highlight<CR>", {noremap=true, silent=true})

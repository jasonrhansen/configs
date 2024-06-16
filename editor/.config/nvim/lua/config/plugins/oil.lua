return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({})
    vim.keymap.set("n", "<leader>o", "<cmd>Oil --float<cr>", { desc = "Open directory in oil" })
    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = "jason-config",
      pattern = { "oil" },
      callback = function()
        vim.keymap.set("n", "<esc>", "<cmd>q!<cr>", { desc = "Close oil window", buffer = true })
      end,
    })
  end,
}

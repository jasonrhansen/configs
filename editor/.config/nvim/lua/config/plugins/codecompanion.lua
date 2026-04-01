return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      interactions = {
        chat = {
          adapter = {
            name = "gemini",
            model = "gemini-2.5-flash",
          },
        },
        inline = {
          adapter = {
            name = "gemini",
            model = "gemini-2.5-flash",
          },
        },
      },
    })
    vim.keymap.set("n", "<Leader>C", function() vim.cmd("CodeCompanionChat toggle") end, { desc = "Code Companion Chat" })
  end,
}

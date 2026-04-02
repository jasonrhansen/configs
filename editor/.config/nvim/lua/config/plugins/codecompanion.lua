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
      prompt_library = {
        markdown = {
          dirs = {
            vim.fn.stdpath("config") .. "/codecompanion_prompts",
          }
        }
      }
    })
    vim.keymap.set({ "n", "v" }, "<leader>A", "<cmd>CodeCompanionActions<cr>", { desc = "Code Companion Actions", noremap = true, silent = true })
    vim.keymap.set({ "n", "v" }, "<Leader>C", "<cmd>CodeCompanionChat toggle<cr>", { desc = "Code Companion Chat", noremap = true, silent = true })
    vim.cmd([[cab cc CodeCompanion]])
  end,
}

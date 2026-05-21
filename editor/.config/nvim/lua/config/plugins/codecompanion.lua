return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "anthropic_sonnet",
        },
        inline = {
          adapter = "anthropic_haiku",
        },
        cli = {
          agent = "claude_code",
          agents = {
            claude_code = {
              cmd = "claude",
              args = {},
              description = "Claude Code CLI",
              provider = "terminal",
            },
          },
        },
      },
      adapters = {
        http = {
          -- 1. Balanced Daily Assistant
          anthropic_sonnet = function()
            return require("codecompanion.adapters").extend("anthropic", {
              name = "anthropic_sonnet",
              formatted_name = "Claude 4.6 Sonnet",
              schema = {
                model = { default = "claude-sonnet-4-6" },
              },
            })
          end,

          -- 2. Lightning Fast / Cheap Assistant
          anthropic_haiku = function()
            return require("codecompanion.adapters").extend("anthropic", {
              name = "anthropic_haiku",
              formatted_name = "Claude 4.5 Haiku",
              schema = {
                model = { default = "claude-haiku-4-5" },
              },
            })
          end,

          -- 3. Heavyweight Architect Assistant
          anthropic_opus = function()
            return require("codecompanion.adapters").extend("anthropic", {
              name = "anthropic_opus",
              formatted_name = "Claude 4.7 Opus",
              schema = {
                model = { default = "claude-opus-4-7" },
              },
            })
          end,
        },
      },
      prompt_library = {
        markdown = {
          dirs = {
            vim.fn.stdpath("config") .. "/codecompanion_prompts",
          },
        },
      },
    })

    vim.keymap.set(
      { "n", "v" },
      "<leader>ca",
      "<cmd>CodeCompanionActions<cr>",
      { desc = "Code Companion Actions", noremap = true, silent = true }
    )
    vim.keymap.set(
      { "n", "v" },
      "<Leader>ch",
      "<cmd>CodeCompanionChat toggle<cr>",
      { desc = "Code Companion Chat", noremap = true, silent = true }
    )
    vim.keymap.set(
      { "n", "v" },
      "<Leader>cl",
      "<cmd>CodeCompanionCLI toggle<cr>",
      { desc = "Code Companion CLI", noremap = true, silent = true }
    )
    vim.cmd([[cab cc CodeCompanion]])
  end,
}

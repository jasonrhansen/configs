return {
  "milanglacier/minuet-ai.nvim",
  config = function()
    require("minuet").setup({
      provider = "gemini",
      provider_options = {
        gemini = {
          model = "gemini-2.0-flash",
          stream = true,
          api_key = "ANTHROPIC_API_KEY",
          optional = {
            generationConfig = {
              maxOutputTokens = 256,
            },
            safetySettings = {
              {
                -- HARM_CATEGORY_HATE_SPEECH,
                -- HARM_CATEGORY_HARASSMENT
                -- HARM_CATEGORY_SEXUALLY_EXPLICIT
                category = "HARM_CATEGORY_DANGEROUS_CONTENT",
                -- BLOCK_NONE
                threshold = "BLOCK_ONLY_HIGH",
              },
            },
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = {},
        keymap = {
          -- accept whole completion
          accept = "<A-J>",
          -- accept one line
          accept_line = "<A-L>",
          -- accept n lines (prompts for number)
          accept_n_lines = "<A-Z>",
          -- Cycle to prev completion item, or manually invoke completion
          prev = "<A-{>",
          -- Cycle to next completion item, or manually invoke completion
          next = "<A-}>",
          dismiss = "<A-E>",
        },
      },
    })
  end,
}

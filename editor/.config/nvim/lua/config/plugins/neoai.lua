return {
  "Bryley/neoai.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  cmd = {
    "NeoAI",
    "NeoAIOpen",
    "NeoAIClose",
    "NeoAIToggle",
    "NeoAIContext",
    "NeoAIContextOpen",
    "NeoAIContextClose",
    "NeoAIInject",
    "NeoAIInjectCode",
    "NeoAIInjectContext",
    "NeoAIInjectContextCode",
  },
  keys = {
    { "<leader>;", desc = "NeoAI" },
    { "<leader>as", desc = "summarize text" },
    { "<leader>ag", desc = "generate git message" },
  },
  config = function()
    require("neoai").setup({
      ui = {
        output_popup_text = "NeoAI",
        input_popup_text = "Prompt",
        width = 30, -- As percentage eg. 30%
        output_popup_height = 80, -- As percentage eg. 80%
      },
      models = {
        {
          name = "openai",
          model = "gpt-3.5-turbo",
          params = nil,
        },
      },
      register_output = {
        ["g"] = function(output)
          return output
        end,
        ["c"] = require("neoai.utils").extract_code_snippets,
      },
      inject = {
        cutoff_width = 75,
      },
      prompts = {
        context_prompt = function(context)
          return "Hey, I'd like to provide some context for future "
            .. "messages. Here is the code/text that I want to refer "
            .. "to in our upcoming conversations:\n\n"
            .. context
        end,
      },
      mappings = {
        ["select_up"] = "<C-k>",
        ["select_down"] = "<C-j>",
      },
      open_api_key_env = "OPENAI_API_KEY",
      shortcuts = {
        {
          name = "textify",
          key = "<leader>as",
          desc = "fix text with AI",
          use_context = true,
          prompt = [[
                Please rewrite the text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors
            ]],
          modes = { "v" },
          strip_function = nil,
        },
        {
          name = "gitcommit",
          key = "<leader>ag",
          desc = "generate git commit message",
          use_context = false,
          prompt = function()
            return [[
                    Using the following git diff generate a consise and
                    clear git commit message, with a short title summary
                    that is 75 characters or less:
                ]] .. vim.fn.system("git diff --cached")
          end,
          modes = { "n" },
          strip_function = nil,
        },
      },
    })

    vim.api.nvim_set_keymap("n", "<leader>;", ":NeoAI<CR>", { desc = "NeoAI", noremap = true, silent = true })
    vim.api.nvim_set_keymap(
      "n",
      "<leader>:",
      ":NeoAIClose<CR>",
      { desc = "Close NeoAI", noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      "x",
      "<leader>;",
      ":NeoAIContext<CR>",
      { desc = "NeoAI Context", noremap = true, silent = true }
    )
  end,
}

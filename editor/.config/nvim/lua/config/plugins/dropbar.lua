return {
  "Bekaboo/dropbar.nvim",
  -- optional, but required for fuzzy finder support
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  config = function()
    local dropbar = require("dropbar")
    local sources = require("dropbar.sources")

    vim.api.nvim_set_hl(0, "DropBarFileName", { fg = "#FFFFFF" })

    local custom_path = {
      get_symbols = function(buff, win, cursor)
        local symbols = sources.path.get_symbols(buff, win, cursor)
        symbols[#symbols].name_hl = "DropBarFileName"
        if vim.bo[buff].modified then
          symbols[#symbols].name = symbols[#symbols].name .. " [+]"
        end
        return symbols
      end,
    }

    dropbar.setup({
      icons = {
        kinds = {
          dir_icon = "",
        },
      },
      menu = {
        keymaps = {
          ["gq"] = "<c-w>q",
        },
      },
      bar = {
        sources = function(buf, _)
          if vim.bo[buf].ft == "markdown" then
            return {
              custom_path,
              sources.markdown,
            }
          end
          if vim.bo[buf].buftype == "terminal" then
            return {
              sources.terminal,
            }
          end
          return {
            custom_path,
          }
        end,
        truncate = false;
      },
    })

    local dropbar_api = require("dropbar.api")
    vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
    vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
    vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
  end,
}

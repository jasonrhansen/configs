return {
  "folke/noice.nvim",
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      cmdline = {
        view = "cmdline",
      },
      lsp = {
        progress = {
          format = {
            {
              "{progress} ",
              key = "progress.percentage",
              contents = {
                { "{data.progress.message} " },
              },
            },
            { "{spinner} ", hl_group = "NoiceLspProgressSpinner" },
            { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
            { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
          },
          format_done = {
            { "✔ ", hl_group = "NoiceLspProgressSpinner" },
            { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
            { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
          },
          throttle = 1000 / 30,
          view = "mini",
        },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      messages = {
        view_search = false,
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        {
          view = "mini",
          filter = {
            find = "more line",
          },
        },
        {
          view = "mini",
          filter = {
            find = "fewer line",
          },
        },
        {
          filter = {
            find = "code_action",
          },
          opts = { skip = true },
        },
        {
          filter = {
            find = "No node found at cursor",
          },
          opts = { skip = true },
        },
        {
          view = "mini",
          filter = {
            find = "Session restored from",
          },
        },
        {
          filter = {
            find = "Diagnosing lua_ls",
          },
          opts = { skip = true },
        },
      },
      format = {
        level = {
          icons = {
            error = require("config.signs").Error,
            warn = require("config.signs").Warning,
            info = require("config.signs").Information,
          },
        },
        progress = {
          width = 10,
        },
        spinner = {
          name = "clock",
        },
      },
    })

    -- LSP hover scrolling
    vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
      if not require("noice.lsp").scroll(4) then
        return "<c-f>"
      end
    end, { silent = true, expr = true })

    vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
      if not require("noice.lsp").scroll(-4) then
        return "<c-b>"
      end
    end, { silent = true, expr = true })
  end,
}

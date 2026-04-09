return {
  "saghen/blink.cmp",
  version = "*",
  opts = {
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    completion = {
      ghost_text = { enabled = true },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = "rounded" },
      },
      menu = {
        border = "none",
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind", gap = 1 },
          },
          components = {
            kind = {
              highlight = "Comment",
            },
            label_description = {
              width = { max = 30 },
              highlight = "NonText",
            },
            label = {
              width = { max = 40 },
            },
          },
        },
      },
    },

    keymap = {
      preset = "default",
      ["<A-}>"] = {
        function(cmp)
          cmp.hide()
          require("minuet.virtualtext").action.next()
        end,
      },
    },

    signature = { enabled = true, window = { border = "rounded" } },

    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer", "rubocop_rules" },
      per_filetype = {
        codecompanion = { "codecompanion", "snippets", "buffer" },
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        rubocop_rules = {
          name = "Rubocop",
          module = "blink_rubocop",
          enabled = function()
            return vim.bo.filetype == "ruby"
          end,

          should_show_items = function()
            local line = vim.api.nvim_get_current_line()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local before_cursor = line:sub(1, col)

            return before_cursor:match("#%s*rubocop:dis") ~= nil
          end,
          score_offset = 100,
        },
      },
    },
  },
}

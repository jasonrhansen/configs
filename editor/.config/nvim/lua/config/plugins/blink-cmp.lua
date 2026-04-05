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
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        codecompanion = { "codecompanion", "snippets", "buffer" },
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  },
}

return {
  "saghen/blink.cmp",
  version = "*",
  opts = {
    completion = {
      ghost_text = {
        enabled = true,
      },
    },

    keymap = {
      preset = "default",
      ["<c-j>"] = { "select_and_accept", "fallback" },
      ["<A-}>"] = {
        function(cmp)
          cmp.hide()
          require("minuet.virtualtext").action.next()
        end,
      },
    },

    signature = {
      enabled = true,
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      -- Disable cmdline completions
      cmdline = {},
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}

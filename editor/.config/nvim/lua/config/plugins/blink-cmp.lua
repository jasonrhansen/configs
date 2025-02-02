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
      default = { "lsp", "path", "snippets", "buffer" },
      -- Disable cmdline completions
      cmdline = {},
    },
  },
  opts_extend = { "sources.default" },
}

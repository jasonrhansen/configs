return {
  "rebelot/kanagawa.nvim",
  lazy = true,
  config = function()
    require("kanagawa").setup({
      transparent = true,
      colors = {
        theme = { all = { ui = { bg_gutter = "none" } } },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none", fg = theme.ui.bg_p2 },
          FloatTitle = { bg = "none", fg = theme.ui.special, bold = true },
          FloatShadow = { bg = "none" },
          MsgArea = { bg = "none" },

          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2, bold = true },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          SnacksPicker = { bg = "none" },
          SnacksPickerBorder = { fg = theme.ui.bg_p2, bg = "none" },
          SnacksPickerTitle = { fg = theme.ui.special, bold = true },
          SnacksInput = { bg = theme.ui.bg_m1 },

          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          NeoTreeFloatTitle = { fg = theme.ui.special, bg = "none" },
        }
      end,
    })
  end,
}

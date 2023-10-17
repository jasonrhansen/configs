local wezterm = require("wezterm")

return {
  use_dead_keys = false,

  force_reverse_video_cursor = true,

  color_scheme = "Kanagawa",

  color_schemes = {
    Kanagawa = {
      foreground = "#dcd7ba",
      background = "#1f1f28",

      cursor_bg = "#c8c093",
      cursor_fg = "#c8c093",
      cursor_border = "#c8c093",

      selection_fg = "#c8c093",
      selection_bg = "#2d4f67",

      scrollbar_thumb = "#16161d",
      split = "#16161d",

      ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
      brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
      indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
    },
  },

  window_decorations = "RESIZE",
  hide_tab_bar_if_only_one_tab = true,

  font = wezterm.font({
    family = "IosevkaTerm Nerd Font",
    weight = "Regular",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  }),

  window_frame = {
    -- The font used in the tab bar.
    -- Roboto Bold is the default; this font is bundled
    -- with wezterm.
    -- Whatever font is selected here, it will have the
    -- main font setting appended to it to pick up any
    -- fallback fonts you may have used there.
    font = wezterm.font({ family = "Cantarell", weight = "Regular" }),

    -- The size of the font in the tab bar.
    -- Default to 10. on Windows but 12.0 on other systems
    font_size = 12.0,

    -- The overall background color of the tab bar when
    -- the window is focused
    active_titlebar_bg = "#363636",

    -- The overall background color of the tab bar when
    -- the window is not focused
    inactive_titlebar_bg = "#363636",

    inactive_titlebar_fg = "#cccccc",
    active_titlebar_fg = "#ffffff",
    inactive_titlebar_border_bottom = "#2b2042",
    active_titlebar_border_bottom = "#2b2042",
    button_fg = "#cccccc",
    button_bg = "#363636",
    button_hover_fg = "#ffffff",
    button_hover_bg = "#3b3052",
  },

  tab_bar_at_bottom = true,

  cursor_blink_rate = 800,

  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 0,
  },

  colors = {
    tab_bar = {
      -- The color of the inactive tab bar edge/divider
      inactive_tab_edge = "#363636",
    },
  },

  ssh_domains = {
    {
      name = "work",
      remote_address = "jh.3-form.com",
      username = "hansen",
    },
  },

  window_close_confirmation = "NeverPrompt",

  audible_bell = "Disabled",
}

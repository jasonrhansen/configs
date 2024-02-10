local wezterm = require("wezterm")

local function increment_opacity(window, amount)
  local overrides = window:get_config_overrides() or {}
  local opacity = overrides.window_background_opacity or 1.0
  opacity = opacity + amount
  if opacity > 1.0 then
    opacity = 1.0
  elseif opacity < 0.0 then
    opacity = 0.0
  end
  overrides.window_background_opacity = opacity
  window:set_config_overrides(overrides)
end

wezterm.on("decrease-opacity", function(window)
  increment_opacity(window, -0.02)
end)

wezterm.on("increase-opacity", function(window)
  increment_opacity(window, 0.02)
end)

wezterm.on("toggle-ligature", function(window)
  local overrides = window:get_config_overrides() or {}
  if not overrides.harfbuzz_features then
    -- Ligatures are disabled by default, so we enable them here.
    overrides.harfbuzz_features = { "calt", "clig", "liga" }
  else
    overrides.harfbuzz_features = nil
  end
  window:set_config_overrides(overrides)
end)

local config = {
  -- For some reason startup time is slow for WebGpu, so I'm using OpenGL for now.
  front_end = "OpenGL",

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

  window_background_opacity = 1.0,
  text_background_opacity = 1.0,

  window_decorations = "RESIZE",
  hide_tab_bar_if_only_one_tab = true,

  -- Turn off ligatures by default.
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

  font = wezterm.font({
    family = "IosevkaTerm Nerd Font",
    weight = "Regular",
  }),

  adjust_window_size_when_changing_font_size = false,

  use_cap_height_to_scale_fallback_fonts = true,

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
    left = 2,
    right = 2,
    top = 0,
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

  keys = {
    {
      key = "-",
      mods = "CTRL|ALT",
      action = wezterm.action.EmitEvent("decrease-opacity"),
    },
    {
      key = "=",
      mods = "CTRL|ALT",
      action = wezterm.action.EmitEvent("increase-opacity"),
    },
    {
      key = "l",
      mods = "CTRL|ALT",
      action = wezterm.action.EmitEvent("toggle-ligature"),
    },
  },
}

for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
  if gpu.backend == 'Vulkan' and gpu.device_type == "IntegratedGpu" then
    config.webgpu_preferred_adapter = gpu
    config.front_end = "WebGpu"
    break
  end
end

return config

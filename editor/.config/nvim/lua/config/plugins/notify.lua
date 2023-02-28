return {
  "rcarriga/nvim-notify",
  config = function()
    vim.o.termguicolors = true
    local signs = require('config.signs')

    require("notify").setup({
      background_colour = "Normal",
      fps = 30,
      level = 2,
      minimum_width = 50,
      render = "default",
      stages = "fade_in_slide_out",
      top_down = true,
      timeout = 1000,
      icons = {
        DEBUG = signs.Debug,
        TRACE = signs.Trace,
        ERROR = signs.Error,
        WARN = signs.Warning,
        INFO = signs.Information,
      },
    })
  end
}

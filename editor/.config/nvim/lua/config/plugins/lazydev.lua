return {
  {
    "folke/lazydev.nvim",
    dependencies = { "justinsgithub/wezterm-types" },
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv", "vim%.loop" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "wezterm-types", mods = { "wezterm" } },
        { path = "LazyVim", words = { "LazyVim" } },
      },
      integrations = {
        lspconfig = true,
        cmp = true,
      },
      enabled = function()
        return vim.g.lazydev_enabled ~= false
      end,
    },
  },
}

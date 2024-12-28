return {
  "nvim-neorg/neorg",
  enabled = false,
  lazy = false,
  version = "*",
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {
          config = {
            icon_preset = "diamond",
          },
        },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
      },
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = "jason-config",
      pattern = { "norg" },
      callback = function()
        vim.wo.conceallevel = 3
      end,
    })
  end,
}

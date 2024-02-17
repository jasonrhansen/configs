return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup({
      use_default_keymaps = false,
    })

    vim.keymap.set("n", "<leader>m", function()
      require("treesj").toggle({
        split = { recursive = true },
        join = { recursive = true },
      })
    end, { desc = "Toggle split/join recursive" })

    vim.keymap.set("n", "<leader>M", function()
      require("treesj").toggle({
        split = { recursive = false },
        join = { recursive = false },
      })
    end, { desc = "Toggle split/join" })
  end,
}

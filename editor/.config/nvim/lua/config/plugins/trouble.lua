local M = {
  "folke/trouble.nvim",
}

function M.config()
  local trouble = require("trouble")

  trouble.setup({})

  local wk = require("which-key")
  wk.add({
    { "<leader>x", group = "Trouble" },
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
  })
end

return M

return {
  "sindrets/diffview.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("diffview").setup({
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
      hooks = {
        diff_buf_read = function()
          vim.opt_local.wrap = false
          vim.opt_local.list = false
        end,
      },
    })

    local toggle_diffview = function()
      local lib = require("diffview.lib")
      local view = lib.get_current_view()
      if view then
        -- Current tabpage is a Diffview; close it
        vim.cmd.DiffviewClose()
      else
        -- No open Diffview exists: open a new one
        vim.cmd.DiffviewOpen()
      end
    end

    require("which-key").add({ "<leader>D", toggle_diffview, desc = "Toggle diffview" })
  end,
}

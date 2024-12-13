return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require("oil")
    oil.setup({})
    vim.keymap.set("n", "<leader>o", "<cmd>Oil --float<cr>", { desc = "Open directory in oil" })
    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = "jason-config",
      pattern = { "oil" },
      callback = function()
        vim.keymap.set("n", "<esc>", "<cmd>q!<cr>", { desc = "Close oil window", buffer = true })
        vim.keymap.set("n", "<C-w>", function()
          local entry = oil.get_cursor_entry()
          if entry.type ~= "file" then
            return
          end
          local win = require("window-picker").pick_window({
            autoselect_one = true,
            include_current_win = true,
          })

          if win then
            local bufnr = vim.api.nvim_get_current_buf()
            local lnum = vim.api.nvim_win_get_cursor(0)[1]
            local winnr = vim.api.nvim_win_get_number(win)
            vim.cmd(winnr .. "windo buffer " .. bufnr)
            vim.api.nvim_win_call(win, function()
              vim.api.nvim_win_set_cursor(win, { lnum, 1 })
              oil.select({
                close = false,
              }, function() end)
            end)
            return
          end
        end, {
          desc = "Open with window picker",
          buffer = true,
        })
      end,
    })
  end,
}

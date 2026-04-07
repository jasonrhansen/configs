local detail = false

return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require("oil")
    oil.setup({
      keymaps = {
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            detail = not detail
            if detail then
              require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
            else
              require("oil").set_columns({ "icon" })
            end
          end,
        },
        ["<esc>"] = { "actions.close", mode = "n" },
        ["gq"] = { "actions.close", mode = "n" },
        ["<leader>cf"] = {
          desc = "Copy file name",
          callback = function()
            local entry = oil.get_cursor_entry()
            if not entry then
              return
            end
            local name = entry.name .. (entry.type == "directory" and "/" or "")
            vim.fn.setreg("+", name)
            vim.notify("Copied: " .. name)
          end,
        },
        ["<leader>cp"] = {
          desc = "Copy file path",
          callback = function()
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()
            if not entry or not dir then
              return
            end
            local path = vim.fs.joinpath(dir, entry.name) .. (entry.type == "directory" and "/" or "")
            vim.fn.setreg("+", path)
            vim.notify("Path copied to clipboard")
          end,
        },
        ["<C-w>"] = {
          desc = "Open with window picker",
          callback = function()
            local entry = oil.get_cursor_entry()
            if not entry or entry.type ~= "file" then
              return
            end

            local full_path = vim.fs.joinpath(oil.get_current_dir(), entry.name)

            oil.close()

            local win = Snacks.picker.util.pick_win()
            if win and vim.api.nvim_win_is_valid(win) then
              vim.api.nvim_set_current_win(win)
              vim.cmd.edit(full_path)
            end
          end,
        },
      },
      float = {
        max_width = 100,
        max_height = 30,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
    })
    vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Open directory in oil" })
  end,
}

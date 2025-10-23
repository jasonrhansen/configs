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
          mode = "n",
          callback = function()
            local entry = oil.get_cursor_entry()
            if not entry then
              return
            end
            local name = entry.name
            if entry.type == "directory" then
              name = name .. "/"
            end
            vim.fn.setreg("+", name)
            print("Copied file name to system clipboard")
          end,
        },
        ["<leader>cp"] = {
          desc = "Copy file path",
          mode = "n",
          callback = function()
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()
            if not entry or not dir then
              return
            end
            local name = entry.name
            if entry.type == "directory" then
              name = name .. "/"
            end
            local path = dir .. name
            vim.fn.setreg("+", path)
            print("Copied file path to system clipboard")
          end,
        },
        ["<leader>cd"] = {
          desc = "Copy oil directory",
          mode = "n",
          callback = function()
            local dir = oil.get_current_dir()
            vim.fn.setreg("+", dir)
            print("Copied directory to system clipboard")
          end,
        },
        ["<c-w>"] = {
          desc = "Open with window picker",
          buffer = true,
          nowait = true,
          callback = function()
            local entry = oil.get_cursor_entry()
            if not entry or entry.type ~= "file" then
              return
            end
            local dir = oil.get_current_dir()
            oil.close({ exit_if_last_buf = false })
            local win = require("window-picker").pick_window({
              filter_rules = {
                autoselect_one = true,
                include_current_win = true,
              },
            })

            if win then
              vim.api.nvim_set_current_win(win)
              local path = vim.fs.joinpath(dir, entry.name)
              vim.cmd.edit(path)
            end
          end,
        },
      },
      float = {
        max_width = 100,
        max_height = 30,
      },
    })
    vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Open directory in oil" })
  end,
}

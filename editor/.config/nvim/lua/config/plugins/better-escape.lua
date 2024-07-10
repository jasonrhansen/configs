return {
  "max397574/better-escape.nvim",
  config = function()
    local escape = function()
      local keys = vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc"
      vim.api.nvim_input(keys)
      -- Clear empty lines
      local current_line = vim.api.nvim_get_current_line()
      if current_line:match("^%s+j$") then
        vim.schedule(function()
          vim.api.nvim_set_current_line("")
        end)
      end
    end

    require("better_escape").setup({
      timeout = vim.o.timeoutlen,
      default_mappings = false,
      mappings = {
        i = {
          j = {
            k = escape,
          },
        },
      },
    })
  end,
}

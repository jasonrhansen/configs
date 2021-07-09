M = {}

require("bufferline").setup {
  options = {
    always_show_bufferline = false,
    offsets = {{filetype = "NvimTree", text = "File Explorer", highlight = "Directory", text_align = "left"}},
  },
}

function M.toggle_bufferline()
  if vim.o.showtabline ~= 2 then
    vim.o.showtabline = 2
  else
    vim.o.showtabline = 0
  end
end

local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    b = {"<cmd>lua require('config.nvim_bufferline').toggle_bufferline()<CR>", "Toggle bufferline"}
  },
})

return M

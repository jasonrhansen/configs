local npairs = require('nvim-autopairs')

npairs.setup()

-- Disable autopairs for single quote in Rust because of lifetime parameters
npairs.get_rule("'")
  :with_pair(function()
    return vim.bo.filetype ~= 'rust'
  end)

-- Get autopairs to work with compe
vim.g.completion_confirm_key = ""
_G.completion_confirm = function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end

vim.api.nvim_set_keymap('i' , '<CR>','v:lua.completion_confirm()', {expr = true , noremap = true})

M = {}

-- Disable default mappings for closer and endwise so we can make them play well with compe.
vim.g.closer_no_mappings = true
vim.g.endwise_no_mappings = true

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.closer_cr()
  if vim.fn.pumvisible() == 1 and vim.fn.complete_info()["selected"] ~= -1 then
    return vim.fn["compe#confirm"]("<CR>")
  else
    -- Call endwise and closer functions
    return t("<CR><Plug>DiscretionaryEnd<Plug>CloserClose")
  end
end

vim.api.nvim_set_keymap("i", "<CR>", [[luaeval('require("config.vim_closer").closer_cr()')]], {expr=true, silent=true})

return M

local M = {}

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = "disable";
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    vsnip = true;
    treesitter = false;
    omni = false;
  };
}

vim.o.completeopt = "menuone,noselect"

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
function M.tab_complete()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

function M.s_tab_complete()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", [[luaeval('require"config.compe".tab_complete()')]], {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", [[luaeval('require"config.compe".tab_complete()')]], {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", [[luaeval('require"config.compe".s_tab_complete()')]], {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", [[luaeval('require"config.compe".s_tab_complete()')]], {expr = true})

vim.api.nvim_set_keymap('i', "<C-Space>", "compe#complete()", {noremap=true, silent=true, expr=true})
vim.api.nvim_set_keymap('i', "<CR>", "compe#confirm('<CR>')", {noremap=true, silent=true, expr=true})
vim.api.nvim_set_keymap('i', "<C-e>", "compe#close('<C-e>')", {noremap=true, silent=true, expr=true})

return M

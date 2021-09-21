local cmp = require("cmp")

local M = {}

local kind_icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "了 ",
  EnumMember = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Property = " ",
  Snippet = "﬌ ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

-- Ordered with highest priority first.
local sources = {
  { name = "nvim_lua", menu = "[Lua]" }, -- Complete neovim's Lua runtime API such as vim.lsp.*
  { name = "nvim_lsp", menu = "[LSP]" },
  { name = "vsnip", menu = "[VSnip]" },
  { name = "path", menu = "[Path]" },
  { name = "calc", menu = "[Calc]" },
  { name = "buffer", menu = "[Buffer]" },
  { name = "tmux", menu = "[Tmux]" },
  { name = "crates", menu = "[Crates]" },
}

local source_names = vim.tbl_map(function(source)
  return { name = source.name }
end, sources)

local source_menus = {}
for _, source in ipairs(sources) do
  source_menus[source.name] = source.menu
end

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  completion = {
    keword_length = 1,
    completeopt = "menu,menuone,noselect",
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    }),
    ["<Tab>"] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
      elseif check_back_space() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n")
      elseif vim.fn["vsnip#available"]() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true), "")
      else
        fallback()
      end
    end,
  },
  -- Order sources by priority
  sources = source_names,
  sorting = {
    priority_weight = 2.,
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = (kind_icons[vim_item.kind] or vim_item.kind) .. " " .. vim_item.kind
      vim_item.menu = source_menus[entry.source.name] or entry.source.name
      return vim_item
    end,
  },
})

return M

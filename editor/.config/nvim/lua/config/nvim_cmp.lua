local cmp = require("cmp")

local M = {}

local kind_icons = {
  Class = "",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "ﰮ",
  Keyword = "",
  Method = "ƒ",
  Module = "",
  Operator = "",
  Property = "",
  Reference = "",
  Snippet = "﬌",
  Struct = "",
  Text = "",
  Unit = "",
  Value = "",
  Variable = "",
}

-- Ordered with highest priority first.
local sources = {
  { name = "nvim_lua", menu = "[Lua]" }, -- Complete neovim's Lua runtime API such as vim.lsp.*
  { name = "nvim_lsp", menu = "[LSP]" },
  { name = "luasnip", menu = "[LuaSnip]" },
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

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
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
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
  },
  -- Order sources by priority
  sources = source_names,
  sorting = {
    priority_weight = 2.,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require("cmp-under-comparator").under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = (kind_icons[vim_item.kind] or " ") .. " " .. vim_item.kind
      vim_item.menu = source_menus[entry.source.name] or entry.source.name
      return vim_item
    end,
  },
})

return M

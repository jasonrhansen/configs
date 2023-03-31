local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "andersevenrud/cmp-tmux",
    -- Better sort for completion items that start with one or more underscores
    "lukas-reineke/cmp-under-comparator",

    -- Displays a popup with possible key bindings of the command you started typing
    "folke/which-key.nvim",
  },
}

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
  { name = "nvim_lua", menu = "Lua" }, -- Complete neovim's Lua runtime API such as vim.lsp.*
  { name = "nvim_lsp", menu = "LSP" },
  { name = "luasnip", menu = "LuaSnip" },
  { name = "path", menu = "Path" },
  { name = "calc", menu = "Calc" },
  { name = "buffer", menu = "Buffer" },
  { name = "tmux", menu = "Tmux" },
  { name = "crates", menu = "Crates" },
}

local source_names = vim.tbl_map(function(source)
  return { name = source.name }
end, sources)

local source_menus = {}
for _, source in ipairs(sources) do
  source_menus[source.name] = source.menu
end

function M.config()
  local cmp = require("cmp")

  vim.o.completeopt = "menu,menuone,noselect"

  local luasnip = require("luasnip")

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
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
      ["<C-j>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          if luasnip.expandable() then
            luasnip.expand()
          else
            cmp.confirm({ select = true })
          end
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
      ["<M-]>"] = cmp.mapping(function(fallback)
        cmp.mapping.close()(fallback)
        require("copilot.suggestion").next()
      end),
      ["<M-j>"] = cmp.mapping(function(fallback)
        cmp.mapping.close()(fallback)
        require("copilot.suggestion").accept()
      end),
      ["<M-l>"] = cmp.mapping(function(fallback)
        cmp.mapping.close()(fallback)
        require("copilot.suggestion").accept_line()
      end),
      ["<M-w>"] = cmp.mapping(function(fallback)
        cmp.mapping.close()(fallback)
        require("copilot.suggestion").accept_word()
      end),
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
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = (kind_icons[vim_item.kind] or "?") .. " "
        vim_item.menu = source_menus[entry.source.name] or entry.source.name
        return vim_item
      end,
    },
  })
end

return M

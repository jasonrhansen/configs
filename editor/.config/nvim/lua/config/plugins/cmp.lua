local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-cmdline",
    "FelipeLema/cmp-async-path",
    "petertriho/cmp-git",
    "andersevenrud/cmp-tmux",
    "mattn/emmet-vim",
    "dcampos/cmp-emmet-vim",
    -- Better sort for completion items that start with one or more underscores
    "lukas-reineke/cmp-under-comparator",
    -- vscode-like pictograms for completion items
    "onsails/lspkind-nvim",
  },
}

-- Ordered with highest priority first.
local sources = {
  { name = "nvim_lua", menu = "Lua" }, -- Complete neovim's Lua runtime API such as vim.lsp.*
  { name = "nvim_lsp", menu = "LSP" },
  { name = "emmet_vim", menu = "Emmet" },
  { name = "luasnip", menu = "LuaSnip" },
  { name = "async_path", menu = "Path" },
  { name = "buffer", menu = "Buffer" },
  { name = "tmux", menu = "Tmux" },
  { name = "crates", menu = "Crates" },
}


local source_names = vim.tbl_map(function(source)
  return { name = source.name }
end, sources)

local source_menus = {}
for _, source in ipairs(sources) do
  source_menus[source.name] = "   " .. source.menu
end

function M.config()
  local cmp = require("cmp")

  vim.o.completeopt = "menu,menuone,noselect"

  local luasnip = require("luasnip")

  cmp.setup({

    enabled = function()
      local disabled = false
      disabled = disabled or (vim.api.nvim_buf_get_option(0, "buftype") == "prompt")
      disabled = disabled or (vim.fn.reg_recording() ~= "")
      disabled = disabled or (vim.fn.reg_executing() ~= "")
      if disabled then
        return false
      end

      -- Disable completion in comments.
      local context = require("cmp.config.context")
      -- Keep command mode completion enabled when cursor is in a comment.
      if vim.api.nvim_get_mode().mode == "c" then
        return true
      else
        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
      end
    end,
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
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.recently_used,
        require("cmp-under-comparator").under,
        cmp.locality,
        cmp.config.compare.kind,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. (strings[1] or "") .. " "
        vim_item.menu = source_menus[entry.source.name] or entry.source.name

        return kind
      end,
    },
  })


  -- Set configuration for specific filetype.
  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "cmp_git" },
    }, {
      { name = "buffer" },
    }),
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })

end

return M

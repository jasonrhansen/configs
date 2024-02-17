local M = {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
  },
}

function M.config()
  -- Enables friendly-snippets
  require("luasnip.loaders.from_vscode").lazy_load()

  local luasnip = require("luasnip")
  local s = luasnip.s
  local i = luasnip.insert_node
  local f = luasnip.function_node
  local fmt = require("luasnip.extras.fmt").fmt
  local same = function(index)
    return f(function(args)
      return args[1]
    end, { index })
  end

  luasnip.add_snippets("rust", {
    s(
      "modtest",
      fmt(
        [[
        #[cfg(test)]
        mod test {{
            use super::*;
            {}
        }}
        ]],
        i(0)
      )
    ),

    s(
      "tokiotest",
      fmt(
        [[
        #[tokio::test]
        async fn {}() {{
            {}
        }}
        ]],
        { i(1, "name"), i(2, "unimplemented!()") }
      )
    ),

    s("eq", fmt("assert_eq!({}, {});{}", { i(1), i(2), i(0) })),

    s("pd", fmt([[println!("{}: {{:?}}", {});]], { same(1), i(1) })),
  })

  -- Keymaps
  local wk = require("which-key")
  wk.register({
    ["<C-j>"] = {
      function()
        if luasnip.expand_or_jumpable() then
          luasnip.jump(1)
        end
      end,
      "Snippet - expand or jump next",
    },
  }, { mode = "i", noremap = false })
  wk.register({
    ["<C-j>"] = {
      function()
        luasnip.jump(1)
      end,
      "Snippet - jump next",
    },
  }, { mode = "s" })
  wk.register({
    ["<C-k>"] = {
      function()
        luasnip.jump(-1)
      end,
      "Snippet - jump previous",
    },
  }, { mode = "i" })
  wk.register({
    ["<C-k>"] = {
      function()
        luasnip.jump(-1)
      end,
      "Snippet - jump previous",
    },
  }, { mode = "s" })
  wk.register({
    ["<C-e>"] = {
      "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'",
      "Snippet - next choice",
      expr = true,
    },
  }, { mode = "i", noremap = false })
  wk.register({
    ["<C-e>"] = {
      "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'",
      "Snippet - next choice",
      expr = true,
    },
  }, { mode = "s", noremap = false })
end

return M

local M = {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
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

  vim.keymap.set("i", "<C-j>", function()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    end
  end, { desc = "Snippet: Expand/Jump Next" })

  vim.keymap.set("s", "<C-j>", function()
    if luasnip.jumpable(1) then
      luasnip.jump(1)
    end
  end, { desc = "Snippet: Jump Next" })

  vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end, { desc = "Snippet: Jump Previous" })

  vim.keymap.set({ "i", "s" }, "<C-e>", function()
    if luasnip.choice_active() then
      luasnip.change_choice(1)
    end
  end, { desc = "Snippet: Next Choice" })

  vim.api.nvim_create_autocmd("ModeChanged", {
  group = "jason-config",
  pattern = { "s:n", "i:n" }, -- From Select/Insert to Normal
  callback = function()
    if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
       and not luasnip.session.jump_active then
      luasnip.unlink_current()
    end
  end,
})
end

return M

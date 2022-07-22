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

  s("eq", fmt("assert_eq!({}, {});{}", { i(1), i(2), i(0) })),

  s("pd", fmt([[println!("{}: {{:?}}", {});]], { same(1), i(1) })),
})

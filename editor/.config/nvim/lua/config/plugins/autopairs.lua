return {
  "windwp/nvim-autopairs",
  -- Using this specific commit until the following issue is resolved:
  -- https://github.com/windwp/nvim-autopairs/issues/430
  commit = "00def0123a1a728c313a7dd448727eac71392c57",
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({})

    local Rule = require("nvim-autopairs.rule")

    autopairs.add_rules({
      Rule('r#"', '"#', "rust"),
      Rule('r##"', '"##', "rust"),
      Rule('r###"', '"###', "rust"),
    })

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    ---@diagnostic disable-next-line: undefined-field
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}

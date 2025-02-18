return {
  "windwp/nvim-autopairs",
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
      disable_filetype = { "snacks_picker_input" },
    })

    local Rule = require("nvim-autopairs.rule")

    autopairs.add_rules({
      Rule('r#"', '"#', "rust"),
      Rule('r##"', '"##', "rust"),
      Rule('r###"', '"###', "rust"),
    })
  end,
}

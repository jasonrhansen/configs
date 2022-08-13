local autopairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

autopairs.setup({})

-- Expand braces on enter key, except for Ruby.
autopairs.remove_rule("{")
autopairs.add_rules({
  Rule("{", "}", "-ruby"):end_wise(),
  Rule("{", "}", "ruby"),
})

-- Arrow functions in javascript/typescript.
autopairs.add_rule(
  Rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript" })
    :use_regex(true)
    :set_end_pair_length(2)
)

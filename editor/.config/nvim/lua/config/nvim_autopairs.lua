local autopairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

autopairs.setup({})

-- Arrow functions in javascript/typescript.
autopairs.add_rule(
  Rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript" })
    :use_regex(true)
    :set_end_pair_length(2)
)

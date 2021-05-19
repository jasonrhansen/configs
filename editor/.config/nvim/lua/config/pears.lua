local R = require "pears.rule"

vim.g.endwise_no_mappings = true

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

require "pears".setup(function(conf)
  conf.remove_pair_on_outer_backspace(false)
  conf.expand_on_enter(false)

  local quotes_should_expand = R.all_of(
    R.not_(R.child_of_node("string", true)),
    R.not_(R.start_of_context "[a-zA-Z0-9]"),
    R.not_(R.match_next "[a-zA-Z0-9]")
  )

  conf.pair("'", {
    close = "'",
    filetypes = {
      exclude = {"comment"}
    },
    should_expand = R.all_of(
      -- Disable for Rust lifetimes
      R.not_(R.child_of_node("type_parameters", true)),
      R.not_(R.child_of_node("type_arguments", true)),

      quotes_should_expand
    )
  })

  conf.pair('"', {
    close = '"',
    filetypes = {
      exclude = {"vim", "comment"}
    },
    should_expand = quotes_should_expand
  })

  conf.pair("`", {
    close = "`",
    filetypes = {
      exclude = {"comment"}
    },
    should_expand = quotes_should_expand
  })

  conf.pair('"""', {
    close = '"""',
    filetypes = {
      exclude = {"comment"}
    },
    should_expand = quotes_should_expand
  })

  conf.pair("'''", {
    close = "'''",
    filetypes = {
      exclude = {"comment"}
    },
    should_expand = quotes_should_expand
  })

  conf.pair("```", {
    close = "```",
    filetypes = {
      exclude = {"comment"}
    },
    should_expand = quotes_should_expand
  })

  local brackets_should_expand = R.all_of(
    R.not_(R.child_of_node("string", true)),
    R.not_(R.match_next "[a-zA-Z0-9\"'([{]")
  )

  conf.pair('(', {
    close = ')',
    filetypes = {
      exclude = {"comment"}
    },
    should_expand = brackets_should_expand
  })

  conf.pair('[', {
    close = ']',
    filetypes = {
      exclude = {"comment"}
    },
    should_expand = brackets_should_expand
  })

  conf.pair('{', {
    close = '}',
    filetypes = {
      exclude = {"comment"}
    },
    should_expand = brackets_should_expand
  })
end)
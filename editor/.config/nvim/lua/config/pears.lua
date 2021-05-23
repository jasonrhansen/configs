local R = require "pears.rule"

require "pears".setup(function(conf)
  conf.on_enter(function(pears_handle)
    if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
      return vim.fn["compe#confirm"]("<CR>")
    else
      pears_handle()
    end
  end)

  conf.remove_pair_on_outer_backspace(false)
  conf.preset("php")
  conf.preset("tag_matching")

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
  -- XML/HTML comments
  conf.pair("<!--", {
    close = "-->",
    filetypes = {
      "html",
      "xml",
      "eruby",
    }
  })
end)

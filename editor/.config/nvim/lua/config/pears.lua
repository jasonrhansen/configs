local treesitter_config = require("config.treesitter")
local R = require("pears.rule")

require("pears").setup(function(conf)
  conf.remove_pair_on_outer_backspace(false)
  conf.disable(function (bufnr)
    local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
    -- Disable for telescope.
    if filetype == "" then
      return true
    end
    -- Use the same disabling logic I use for treesitter.
    return treesitter_config.disable(filetype, bufnr)
  end)
  conf.preset("php")
  conf.preset("tag_matching", {
    filetypes = {
      include = {
        "javascriptreact",
        "typescriptreact",
        "php",
        "jsx",
        "tsx",
        "html",
        "xml",
        "markdown",
        "eruby",
      },
    },
  })

  local quotes_should_expand = R.all_of(
    R.not_(R.child_of_node("string", true)),
    R.not_(R.start_of_context("[a-zA-Z0-9&]")),
    R.not_(R.match_next("[a-zA-Z0-9]"))
  )

  conf.pair("'", {
    close = "'",
    filetypes = {
      exclude = { "comment" },
    },
    should_expand = R.all_of(
      -- Disable for Rust lifetimes
      R.not_(R.child_of_node("type_parameters", true)),
      R.not_(R.child_of_node("type_arguments", true)),

      quotes_should_expand
    ),
  })

  conf.pair('"', {
    close = '"',
    filetypes = {
      exclude = { "vim", "comment" },
    },
    should_expand = quotes_should_expand,
  })

  conf.pair("`", {
    close = "`",
    filetypes = {
      exclude = { "comment" },
    },
    should_expand = quotes_should_expand,
  })

  conf.pair('"""', {
    close = '"""',
    filetypes = {
      exclude = { "comment" },
    },
    should_expand = quotes_should_expand,
  })

  conf.pair("'''", {
    close = "'''",
    filetypes = {
      exclude = { "comment" },
    },
    should_expand = quotes_should_expand,
  })

  conf.pair("```", {
    close = "```",
    filetypes = {
      exclude = { "comment" },
    },
    should_expand = quotes_should_expand,
  })

  local brackets_should_expand = R.all_of(
    R.not_(R.child_of_node("string", true)),
    R.not_(R.match_next("[a-zA-Z0-9\"'([{]"))
  )

  conf.pair("(", {
    close = ")",
    filetypes = {
      exclude = { "comment" },
    },
    should_expand = brackets_should_expand,
  })

  conf.pair("[", {
    close = "]",
    filetypes = {
      exclude = { "comment" },
    },
    should_expand = brackets_should_expand,
  })

  local enter_pressed = R.virtual_key(R.VirtualKey.ENTER)

  conf.pair("{", {
    close = "}",
    filetypes = {
      exclude = { "comment" },
    },
    expand_when = enter_pressed,
    should_expand = brackets_should_expand,
  })

  -- XML/HTML comments
  conf.pair("<!--", {
    close = "-->",
    filetypes = {
      "html",
      "xml",
      "eruby",
    },
  })
end)

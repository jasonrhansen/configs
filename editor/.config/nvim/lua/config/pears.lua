require "pears".setup(function(conf)
  conf.pair("'", {
    close = "'",
    should_expand = function()
      -- Disable expanding single quote in Rust because of lifetimes
      return vim.api.nvim_buf_get_option(0, "filetype") ~= 'rust'
    end
  })

  conf.pair('"', {
    close = '"',
    should_expand = function()
      -- Disable expanding double quote for vimscript because of comments
      return vim.api.nvim_buf_get_option(0, "filetype") ~= 'vim'
    end
  })

  -- Make it work with compe
  conf.on_enter(function(pears_handle)
    if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
      return vim.fn["compe#confirm"]("<CR>")
    else
      return pears_handle()
    end
  end)
end)

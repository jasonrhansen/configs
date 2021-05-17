require "pears".setup(function(conf)
  conf.pair("'", {
    close = "'",
    filetypes = {
      -- Disable expanding single quote in Rust because of lifetimes
      exclude = {'rust'}
    },
  })

  conf.pair('"', {
    close = '"',
    filetypes = {
      -- Disable expanding double quote for vimscript because of comments
      exclude = {'vim'}
    },
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

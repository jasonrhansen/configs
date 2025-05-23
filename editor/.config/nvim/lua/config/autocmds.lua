vim.api.nvim_create_augroup("jason-config", { clear = true })

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = "jason-config",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

-- Automatically rebalance windows on vim resize
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = "jason-config",
  callback = function()
    vim.cmd.wincmd("=")
  end,
})

-- Automatically delete hidden fugitive buffers
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  group = "jason-config",
  pattern = { "fugitive:///*" },
  callback = function()
    vim.bo.bufhidden = "delete"
  end,
})

-- Treat *.pdf.erb like *.html.erb for syntax highlighting.
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = "jason-config",
  pattern = { "*.pdf.erb" },
  callback = function()
    vim.b.eruby_subtype = "html"
    vim.cmd("do Syntax")
  end,
})


-- Cosmic config uses ron files without extensions so they don't get automatically detected.
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = "jason-config",
  pattern = { "*/.config/cosmic/**/*" },
  callback = function()
    vim.opt.filetype = 'ron'
  end,
})

-- For SSH sessions, make yanks use OSC 52 by writing to the + register.
if require("util").is_ssh_session() then
  vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = "jason-config",
    callback = function(_)
      local operator = vim.v.event.operator
      local regname = vim.v.event.regname
      if operator == "y" and regname == "" then
        vim.fn.setreg("+", vim.fn.getreg('"'))
      end
    end,
  })
end

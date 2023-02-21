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

-- Options for gitcommit window
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "jason-config",
  pattern = { "gitcommit" },
  callback = function()
    vim.wo.colorcolumn = 80
    vim.cmd.startinsert()
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

-- Automatically set tmux window name.
if vim.fn.exists("$TMUX") == 1 and vim.fn.exists("$NORENAME") == 0 then
  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = "jason-config",
    callback = function()
      if vim.o.buftype == "" then
        vim.fn.system("tmux rename-window " .. vim.fn.expand("%:t:S"))
      end
    end,
  })

  vim.api.nvim_create_autocmd({ "VimLeave" }, {
    group = "jason-config",
    callback = function()
      vim.fn.system("tmux set-window automatic-rename on")
    end,
  })
end

-- Treat *.pdf.erb like *.html.erb for syntax highlighting.
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = "jason-config",
  pattern = { "*.pdf.erb" },
  callback = function()
    vim.b.eruby_subtype = 'html'
    vim.cmd('do Syntax')
  end,
})

-- Make working with large files a lot more responsive.
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
  group = "jason-config",
  pattern = { "*" },
  callback = function(ev)
    if require("util").is_large_file(ev.buf) then
      print("Large file, disabling some options to increase performance...")
      vim.opt.undofile = false
      vim.opt.swapfile = false
      vim.opt_local.foldmethod = "manual"
      vim.cmd("IndentBlanklineDisable")
      vim.cmd("TSContextDisable")
      vim.diagnostic.disable(ev.buf)
      require('cmp').setup.buffer({ enabled = false })
      require('nvim-autopairs').disable()
    end
  end,
})

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
    vim.bo = "delete"
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
    end
  })

  vim.api.nvim_create_autocmd({ "VimLeave" }, {
    group = "jason-config",
    callback = function()
      vim.fn.system("tmux set-window automatic-rename on")
    end
  })
end

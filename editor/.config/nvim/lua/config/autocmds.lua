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
    vim.opt.filetype = "ron"
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

--------------------------------------------------------------------------------
-- Highlight Trailing Whitespace
--------------------------------------------------------------------------------

local ws_group = vim.api.nvim_create_augroup("TrailingWhitespace", { clear = true })

-- Ensure the highlight group exists even after colorscheme changes
local function set_whitespace_hl()
  vim.api.nvim_set_hl(0, "TrailingWhitespace", { link = "Search", default = true })
end

-- Run it now, and also every time the colorscheme changes
set_whitespace_hl()
vim.api.nvim_create_autocmd("ColorScheme", {
  group = ws_group,
  callback = set_whitespace_hl,
})

-- Apply the visual match to the window
vim.api.nvim_create_autocmd({ "BufWinEnter", "InsertLeave" }, {
  group = ws_group,
  callback = function()
    local buftype = vim.bo.buftype
    local filetype = vim.bo.filetype
    local excluded_fts = { "mason", "lazy", "oil", "gitmessengerpopup", "qf" }

    if buftype ~= "" or vim.tbl_contains(excluded_fts, filetype) then
      return
    end

    -- Only add the match if it doesn't already exist in this window
    local exists = false
    for _, m in ipairs(vim.fn.getmatches()) do
      if m.group == "TrailingWhitespace" then
        exists = true
      end
    end

    if not exists then
      vim.fn.matchadd("TrailingWhitespace", [[\s\+$]])
    end
  end,
})

-- Remove highlights while typing to avoid distraction
vim.api.nvim_create_autocmd("InsertEnter", {
  group = ws_group,
  callback = function()
    for _, m in ipairs(vim.fn.getmatches()) do
      if m.group == "TrailingWhitespace" then
        vim.fn.matchdelete(m.id)
      end
    end
  end,
})

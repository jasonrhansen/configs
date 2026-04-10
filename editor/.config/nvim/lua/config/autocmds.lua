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

--------------------------------------------------------------------------------
-- Angular: Jump Between Files
--------------------------------------------------------------------------------

local function jump_to_angular_file(suffix)
  local base_path = vim.fn.expand("%:p:r"):gsub("%.spec$", "")
  local target_file = base_path .. suffix

  if vim.fn.filereadable(target_file) == 1 then
    vim.cmd("edit " .. target_file)
  else
    if suffix == ".scss" then
      local css_fallback = base_path .. ".css"
      if vim.fn.filereadable(css_fallback) == 1 then
        vim.cmd("edit " .. css_fallback)
        return
      end
    end
    vim.notify("Angular file not found: " .. target_file, vim.log.levels.WARN)
  end
end

local function setup_angular_keymaps()
  -- Check if we are in an Angular
  local root = vim.fs.root(0, { "angular.json", "nx.json" })
  if not root then
    return
  end

  local jump_to_ts = function()
    return jump_to_angular_file(".ts")
  end

  local jump_to_html = function()
    return jump_to_angular_file(".html")
  end

  local jump_to_scss = function()
    return jump_to_angular_file(".scss")
  end

  local jump_to_spec = function()
    return jump_to_angular_file(".spec.ts")
  end

  local pick_window = require("util").pick_window
  local mappings = {
    ["<leader>nt"] = { jump_to_ts, "Angular: Jump to TS" },
    ["<leader>nh"] = { jump_to_html, "Angular: Jump to HTML" },
    ["<leader>nc"] = { jump_to_scss, "Angular: Jump to SCSS/CSS" },
    ["<leader>ns"] = { jump_to_spec, "Angular: Jump to Spec" },
    ["<leader>nnt"] = { pick_window(jump_to_ts), "Angular: Pick & Jump to TS" },
    ["<leader>nnh"] = { pick_window(jump_to_html), "Angular: Pick & Jump to HTML" },
    ["<leader>nnc"] = { pick_window(jump_to_scss), "Angular: Pick & Jump to SCSS/CSS" },
    ["<leader>nns"] = { pick_window(jump_to_spec), "Angular: Pick & Jump to Spec" },
  }

  for key, map in pairs(mappings) do
    vim.keymap.set("n", key, map[1], { buffer = true, silent = true, desc = map[2] })
  end
end

-- Only trigger the check for relevant filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "html", "css", "scss" },
  callback = setup_angular_keymaps,
})

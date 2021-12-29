local trouble = require("trouble")
local lsp = require("config.lsp")

trouble.setup({
  position = "bottom", -- position of the list can be: bottom, top, left, right
  height = 10, -- height of the trouble list when position is top or bottom
  width = 50, -- width of the list when position is left or right
  icons = true, -- use devicons for filenames
  mode = "workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
  fold_open = "", -- icon used for open folds
  fold_closed = "", -- icon used for closed folds
  action_keys = { -- key mappings for actions in the trouble list
    close = "q", -- close the list
    cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
    refresh = "r", -- manually refresh
    jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
    jump_close = { "o" }, -- jump to the diagnostic and close the list
    open_split = { "<c-x>" }, -- open buffer in new split
    open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
    open_tab = { "<c-t>" }, -- open buffer in new tab
    toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = "P", -- toggle auto_preview
    hover = "K", -- opens a small poup with the full multiline message
    preview = "p", -- preview the diagnostic location
    close_folds = { "zM", "zm" }, -- close all folds
    open_folds = { "zR", "zr" }, -- open all folds
    toggle_fold = { "zA", "za" }, -- toggle fold of current file
    previous = "k", -- preview item
    next = "j", -- next item
  },
  indent_lines = true, -- add an indent guide below the fold icons
  auto_open = false, -- automatically open the list when you have diagnostics
  auto_close = false, -- automatically close the list when you have no diagnostics
  auto_preview = false, -- automatyically preview the location of the diagnostic. <esc> to close preview and go back to last window
  auto_fold = false, -- automatically fold a file trouble list at creation
  signs = {
    -- icons / text used for a diagnostic
    error = lsp.signs.Error,
    warning = lsp.signs.Warning,
    hint = lsp.signs.Hint,
    information = lsp.signs.Information,
    other = "﫠",
  },
  use_lsp_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
})

local wk = require("which-key")
wk.register({
  ["<leader>x"] = {
    name = "Trouble",
    x = { "<cmd>Trouble<cr>", "Trouble" },
    l = { "<cmd>Trouble loclist<cr>", "Trouble loclist" },
    q = { "<cmd>Trouble quickfix<cr>", "Trouble quickfix" },
    w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Trouble lsp workspace diagnostics" },
    d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Trouble lsp document diagnostics" },
    r = { "<cmd>Trouble lsp_references<cr>", "Trouble lsp references" },
  },
})

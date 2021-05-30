-- Misc. key maps defined with which-key

local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    name = "Leader",
    ["<leader>"] = {"<c-^>", "Toggle between buffers"},
    ve = {":vsplit $MYVIMRC<cr>", "Edit init.vim"},
    vs = {":source $MYVIMRC<cr>", "Reload init.vim"},
    w = {"w!<cr>", "Save (force)"},
    q = {":Bdelete<cr>", "Delete buffer"},
    n = {
      name = "Ng Switcher",
      t = "Switch to TS",
      c = "Switch to CSS/SCSS",
      h = "Switch to HTML",
      s = "Switch to Spec",
    }
  },
})

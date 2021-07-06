-- Misc. key maps defined with which-key

local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    name = "Leader",
    ["<leader>"] = {"<c-^>", "Toggle between buffers"},
    ve = {"<cmd>vsplit $MYVIMRC<cr>", "Edit init.vim"},
    vs = {"<cmd>source $MYVIMRC<cr>", "Reload init.vim"},
    w = {"w!<cr>", "Save (force)"},
    q = {"<cmd>Bdelete<cr>", "Delete buffer"},
    n = {
      name = "NG Switcher",
      t = {"<cmd>NgSwitchTS<cr>", "Switch to TS"},
      c = {"<cmd>NgSwitchCSS<cr>", "Switch to CSS/SCSS"},
      h = {"<cmd>NgSwitchHTML<cr>", "Switch to HTML"},
      S = {"<cmd>NgSwitchSpec<cr>", "Switch to Spec"},
      s = {
        name = "NG Switcher (horizontal split)",
        t = {"<cmd>SNgSwitchTS<cr>", "Switch to TS (horizontal split)"},
        c = {"<cmd>SNgSwitchCSS<cr>", "Switch to CSS/SCSS (horizontal split)"},
        h = {"<cmd>SNgSwitchHTML<cr>", "Switch to HTML (horizontal split)"},
        S = {"<cmd>SNgSwitchSpec<cr>", "Switch to Spec (horizontal split)"},
      },
      v = {
        name = "NG Switcher (vertical split)",
        t = {"<cmd>VNgSwitchTS<cr>", "Switch to TS (vertical split)"},
        c = {"<cmd>VNgSwitchCSS<cr>", "Switch to CSS/SCSS (vertical split)"},
        h = {"<cmd>VNgSwitchHTML<cr>", "Switch to HTML (vertical split)"},
        S = {"<cmd>VNgSwitchSpec<cr>", "Switch to Spec (vertical split)"},
      }
    }
  },
})

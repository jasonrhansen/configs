local M = {}

-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- If you want icons for diagnostic errors, you'll need to define them somewhere:
local lsp = require("config.lsp")
vim.fn.sign_define("DiagnosticSignError", { text = lsp.signs.Error, texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = lsp.signs.Warning, texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = lsp.signs.Information, texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = lsp.signs.Hint, texthl = "DiagnosticSignHint" })

require("neo-tree").setup({
  close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      -- indent guides
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      -- expander config, needed for nesting files
      -- if nil and file nesting is enabled, will enable expanders
      with_expanders = nil,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      default = "*",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
    },
    git_status = {
      symbols = {
        -- Change type
        added = "✚",
        deleted = "✖",
        modified = "",
        renamed = "",
        -- Status type
        untracked = "",
        ignored = "◌",
        unstaged = "✗",
        staged = "✓",
        conflict = "",
      },
    },
  },
  window = {
    position = "left",
    width = 40,
    mappings = {
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      ["C"] = "close_node",
      ["<bs>"] = "navigate_up",
      ["."] = "set_root",
      ["H"] = "toggle_hidden",
      ["R"] = "refresh",
      ["/"] = "fuzzy_finder",
      ["f"] = "filter_on_submit",
      ["<c-x>"] = "clear_filter",
      ["a"] = "add",
      ["A"] = "add_directory",
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy", -- takes text input for destination
      ["m"] = "move", -- takes text input for destination
      ["q"] = "close_window",
    },
  },
  nesting_rules = {},
  filesystem = {
    filtered_items = {
      -- When true, they will just be displayed differently than normal items.
      visible = false,
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_by_name = {
        "node_modules",
      },
      -- Remains hidden even if visible is toggled to true.
      never_show = {
        ".DS_Store",
        "thumbs.db",
      },
    },
    -- This will find and focus the file in the active buffer every
    -- time the current file is changed while the tree is open.
    follow_current_file = false,
    -- netrw disabled, opening a directory opens neo-tree
    -- in whatever position is specified in window.position
    -- "open_current",  -- netrw disabled, opening a directory opens within the
    -- window like netrw would, regardless of window.position
    -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    hijack_netrw_behavior = "open_default",
    -- This will use the OS level file watchers to detect changes
    -- instead of relying on nvim autocmd events.
    use_libuv_file_watcher = true,
    window = {
      mappings = {
        ["tf"] = "telescope_find",
        ["tg"] = "telescope_grep",
      },
    },
    commands = {
      telescope_find = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require("telescope.builtin").find_files(M.get_telescope_opts(state, path))
      end,
      telescope_grep = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require("telescope.builtin").live_grep(M.get_telescope_opts(state, path))
      end,
    },
  },
  buffers = {
    show_unloaded = true,
    window = {
      mappings = {
        ["bd"] = "buffer_delete",
      },
    },
  },
  git_status = {
    window = {
      position = "float",
      mappings = {
        ["A"] = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
      },
    },
  },
  event_handlers = {
    {
      event = "file_open_requested",
      handler = function(args)
        local state = args.state
        local path = args.path
        local open_cmd = args.open_cmd or "edit"

        local suitable_window_found = false
        local picked_window_id = require("window-picker").pick_window()
        local success = pcall(vim.api.nvim_set_current_win, picked_window_id)
        if success then
          suitable_window_found = true
        end

        -- find a suitable window to open the file in
        if not suitable_window_found then
          if state.window.position == "right" then
            vim.cmd("wincmd t")
          else
            vim.cmd("wincmd w")
          end
        end
        local attempts = 0
        while attempts < 4 and vim.bo.filetype == "neo-tree" do
          attempts = attempts + 1
          vim.cmd("wincmd w")
        end
        if vim.bo.filetype == "neo-tree" then
          -- Neo-tree must be the only window, restore it's status as a sidebar
          local winid = vim.api.nvim_get_current_win()
          local width = require("neo-tree.utils").get_value(state, "window.width", 40)
          vim.cmd("vsplit " .. path)
          vim.api.nvim_win_set_width(winid, width)
        else
          vim.cmd(open_cmd .. " " .. path)
        end

        -- If you don't return this, it will proceed to open the file using built-in logic.
        return { handled = true }
      end,
    },
  },
})

local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    e = { "<cmd>Neotree toggle<cr>", "Open file tree" },
    ["."] = { "<cmd>Neotree reveal<cr>", "Find file in tree" },
  },
})

function M.get_telescope_opts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    attach_mappings = function(prompt_bufnr)
      local actions = require("telescope.actions")
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if filename == nil then
          filename = selection[1]
        end
        -- any way to open the file without triggering auto-close event of neo-tree?
        require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
      end)
      return true
    end,
  }
end

return M

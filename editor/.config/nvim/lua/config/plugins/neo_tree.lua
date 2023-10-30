-- File manager
local M = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
}

function M.config()
  -- Unless you are still migrating, remove the deprecated commands from v1.x
  vim.g.neo_tree_remove_legacy_commands = 1

  -- If you want icons for diagnostic errors, you'll need to define them somewhere:
  local signs = require("config.signs")
  vim.fn.sign_define("DiagnosticSignError", { text = signs.Error, texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = signs.Warning, texthl = "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInfo", { text = signs.Information, texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = signs.Hint, texthl = "DiagnosticSignHint" })

  local get_telescope_opts = function(state, path)
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
          require("neo-tree.sources.filesystem").navigate(state, state.path, filename, function() end)
        end)
        return true
      end,
    }
  end

  require("neo-tree").setup({
    sources = {
      "filesystem",
      "buffers",
      "git_status",
    },
    default_source = "filesystem",
    source_selector = {
      winbar = true,
      sources = {
        { source = "filesystem", display_name = " 󰉓  Files " },
        { source = "buffers", display_name = " 󰈙  Buffers " },
        { source = "git_status", display_name = " 󰊢  Git " },
      },
    },
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
        default = "🗎",
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
        ["w"] = "open_with_window_picker",
        ["R"] = "refresh",
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
        ["e"] = function()
          vim.api.nvim_exec2("Neotree focus filesystem left", { output = true })
        end,
        ["b"] = function()
          vim.api.nvim_exec2("Neotree focus buffers left", { output = true })
        end,
        ["g"] = function()
          vim.api.nvim_exec2("Neotree focus git_status left", { output = true })
        end,
      },
    },
    nesting_rules = {},
    filesystem = {
      filtered_items = {
        -- When true, they will just be displayed differently than normal items.
        visible = false,
        hide_dotfiles = false,
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
      follow_current_file = {
        enable = true,
      },
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
          ["Tf"] = "telescope_find",
          ["Tg"] = "telescope_grep",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
          ["C"] = "copy_path",
        },
      },
      commands = {
        telescope_find = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require("telescope.builtin").find_files(get_telescope_opts(state, path))
        end,
        telescope_grep = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require("telescope.builtin").live_grep(get_telescope_opts(state, path))
        end,
        copy_path = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require("util").copy_to_clipboard(path)
          print("copied path to clipboard")
        end,
      },
    },
    buffers = {
      show_unloaded = true,
      window = {
        mappings = {
          ["bd"] = "buffer_delete",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
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
  })

  local wk = require("which-key")
  wk.register({
    ["<leader>"] = {
      e = { "<cmd>Neotree toggle<cr>", "Toggle file tree" },
      ["."] = { "<cmd>Neotree reveal<cr>", "Find file in tree" },
    },
  })
end

return M

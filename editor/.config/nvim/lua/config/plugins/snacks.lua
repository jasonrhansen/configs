local pick_window = require("util").pick_window

local function lsp_definitions()
  vim.lsp.buf.definition({
    on_list = function(options)
      if #options.items == 0 then
        return
      end

      -- When defining a function in lua like this:
      --
      --   local foo = function()
      --       ...
      --   end
      --
      -- If I want to jump to its definition, I don't want to get multiple choices
      -- to select from in the picker (one for the binding and one for the function definition).
      -- So if all definitions are on the same line of the same file just jump to the first one.
      local first = options.items[1]
      local same_line = true
      for i = 2, #options.items do
        if options.items[i].lnum ~= first.lnum or options.items[i].filename ~= first.filename then
          same_line = false
          break
        end
      end

      if same_line then
        local location = {
          uri = vim.uri_from_fname(first.filename),
          range = {
            start = { line = first.lnum - 1, character = first.col - 1 },
            ["end"] = { line = first.lnum - 1, character = first.col - 1 },
          },
        }
        vim.lsp.util.show_document(location, "utf-8", { reuse_win = false })
      else
        Snacks.picker.lsp_definitions({
          jump = { reuse_win = false },
        })
      end
    end,
  })
end

local function lsp_declarations()
  Snacks.picker.lsp_declarations({
    jump = { reuse_win = false },
  })
end

local function lsp_references()
  Snacks.picker.lsp_references({
    jump = { reuse_win = false },
  })
end

local function lsp_implementations()
  Snacks.picker.lsp_implementations({
    jump = { reuse_win = false },
  })
end

local function lsp_type_definitions()
  Snacks.picker.lsp_type_definitions({
    jump = { reuse_win = false },
  })
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    input = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    lazygit = {
      configure = true,
    },
    image = {
      enabled = false, -- NOTE: Disable snacks.image
      formats = {}, -- HACK: Disable image preview for other modules like picker
    },
    indent = {
      enabled = false,
      animate = {
        enabled = false,
      },
    },
    uti = { enabled = true },
    picker = {
      -- your picker configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      win = {
        -- input window
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<c-w>"] = { "pick_window", mode = { "n", "i" } },
          },
        },
      },
      actions = {
        pick_window = function(picker)
          local item = picker:current()
          if not item or not item._path then
            return
          end

          picker:close()

          local win = Snacks.picker.util.pick_win()

          if win and vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_set_current_win(win)
            vim.cmd.edit(item._path)
          else
            Snacks.picker.resume()
          end
        end,
      },
    },
  },
  keys = {
    {
      "<leader>z",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>,",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>fG",
      function()
        Snacks.picker.git_grep()
      end,
      desc = "Git Grep",
    },
    {
      "<leader>?",
      function()
        Snacks.picker.git_grep()
      end,
      desc = "Git Grep",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>N",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notification History",
    },
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "File Explorer",
    },
    {
      "<leader>.",
      function()
        Snacks.explorer.reveal({ file = vim.fn.expand("%:p") })
      end,
      desc = "File Explorer reveal",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = tostring(vim.fn.stdpath("config")) })
      end,
      desc = "Find Config File",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find Git Files",
    },
    {
      "<leader>f.",
      function()
        Snacks.picker.files({
          dirs = { vim.fn.expand("%:p:h") },
        })
      end,
      desc = "Find Files in current directory",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent",
    },
    {
      "<leader>Gl",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Git Log",
    },
    {
      "<leader>GL",
      function()
        Snacks.picker.git_log_line()
      end,
      desc = "Git Log Line",
    },
    {
      "<leader>Gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git Status",
    },
    {
      "<leader>Gd",
      function()
        Snacks.picker.git_diff()
      end,
      desc = "Git Diff (Hunks)",
    },
    {
      "<leader>Gf",
      function()
        Snacks.picker.git_log_file()
      end,
      desc = "Git Log File",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Open Buffers",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
    {
      '<leader>f"',
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>f/",
      function()
        Snacks.picker.search_history()
      end,
      desc = "Search History",
    },
    {
      "<leader>fa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>fB",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>fC",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>fD",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>fd",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Buffer Diagnostics",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>fH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Highlights",
    },
    {
      "<leader>fi",
      function()
        Snacks.picker.icons()
      end,
      desc = "Icons",
    },
    {
      "<leader>fj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "Jumps",
    },
    {
      "<leader>fk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>fl",
      function()
        Snacks.picker.loclist()
      end,
      desc = "Location List",
    },
    {
      "<leader>fm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Marks",
    },
    {
      "<leader>fM",
      function()
        Snacks.picker.man()
      end,
      desc = "Man Pages",
    },
    {
      "<leader>sp",
      function()
        Snacks.picker.lazy()
      end,
      desc = "Search for Plugin Spec",
    },
    {
      "<leader>fq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Quickfix List",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },
    {
      "<leader>fu",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo History",
    },
    {
      "<leader>fC",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Colorschemes",
    },
    {
      "gd",
      lsp_definitions,
      desc = "Goto Definition",
    },
    {
      "gD",
      lsp_declarations,
      desc = "Goto Declaration",
    },
    {
      "gr",
      lsp_references,
      nowait = true,
      desc = "References",
    },
    {
      "gI",
      lsp_implementations,
      desc = "Goto Implementation",
    },
    {
      "gy",
      lsp_type_definitions,
      desc = "Goto T[y]pe Definition",
    },
    {
      "<leader>gd",
      pick_window(lsp_definitions),
      desc = "Pick window and goto Definition",
    },
    {
      "<leader>gD",
      pick_window(lsp_declarations),
      desc = "Pick window and goto Declaration",
    },
    {
      "<leader>gI",
      pick_window(lsp_implementations),
      desc = "Pick window and goto Implementation",
    },
    {
      "<leader>gy",
      pick_window(lsp_type_definitions),
      desc = "Pick window and goto T[y]pe Definition",
    },
    {
      "<leader>fs",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "LSP Symbols",
    },
    {
      "<leader>fS",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "LSP Workspace Symbols",
    },
    {
      "<leader>ft",
      function()
        Snacks.picker.todo_comments()
      end,
      desc = "Todo",
    },
    {
      "<leader>fT",
      function()
        Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
      end,
      desc = "Todo/Fix/Fixme",
    },
    {
      "<leader>q",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete buffer",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Lazygit Current File History",
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit Log (Root)",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
        Snacks.toggle.diagnostics():map("<leader>td")
        Snacks.toggle.treesitter():map("<leader>tT")
        Snacks.toggle.inlay_hints():map("<leader>th")
        Snacks.toggle.indent():map("<leader>ti")
        Snacks.toggle.scroll():map("<leader>tS")
      end,
    })

    -- LSP-integrated file renaming, when renaming files in oil.nvim.
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions[1].type == "move" then
          Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
        end
      end,
    })
  end,
}

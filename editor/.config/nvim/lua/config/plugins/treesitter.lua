local M = {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
    if ts_update ~= nil then
      ts_update()
    end
  end,
  dependencies = {
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
}

function M.config()
  local treesitter = require("nvim-treesitter.configs")

  local disabled_filetypes = { "php", "html" }

  function M.disable(lang, buf)
    return vim.tbl_contains(disabled_filetypes, lang) or require("util").is_large_file(buf)
  end

  local disable_indent = function(lang, bufnr)
    return lang == "ruby" or M.disable(lang, bufnr)
  end

  treesitter.setup({
    ensure_installed = {
      "bash",
      "c",
      "c_sharp",
      "cmake",
      "clojure",
      "comment",
      "commonlisp",
      "cpp",
      "css",
      "cuda",
      "dart",
      "dockerfile",
      "elixir",
      "fish",
      "glsl",
      "go",
      "graphql",
      "help",
      "hjson",
      "html",
      "http",
      "java",
      "javascript",
      "jsdoc",
      "json",
      "json5",
      "jsonc",
      "julia",
      "kotlin",
      "latex",
      "llvm",
      "lua",
      "make",
      "ninja",
      "nix",
      "ocaml",
      "pascal",
      "perl",
      "php",
      "prisma",
      "python",
      "ql",
      "query",
      "r",
      "regex",
      "rst",
      "ruby",
      "rust",
      "scala",
      "scheme",
      "scss",
      "svelte",
      "sql",
      "todotxt",
      "toml",
      "tsx",
      "typescript",
      "vala",
      "verilog",
      "vim",
      "vue",
      "yaml",
      "zig",
    },

    highlight = {
      enable = true,
      disable = M.disable,
    },

    indent = {
      enable = true,
      disable = disable_indent,
    },

    context_commentstring = {
      enable = true,
      disable = M.disable,
      -- Configure nvim-comment to call this with hook.
      enable_autocmd = false,
    },

    endwise = {
      enable = true,
      disable = M.disable,
    },

    textobjects = {
      select = {
        enable = true,
        disable = M.disable,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["am"] = "@function.outer",
          ["im"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      swap = {
        enable = true,
        disable = M.disable,
        swap_next = {
          ["<leader>sa"] = "@parameter.inner",
          ["<leader>sp"] = "@parameter.inner",
          ["<leader>sf"] = "@function.outer",
          ["<leader>sm"] = "@function.outer",
        },
        swap_previous = {
          ["<leader>sA"] = "@parameter.inner",
          ["<leader>sP"] = "@parameter.inner",
          ["<leader>sF"] = "@function.outer",
          ["<leader>sM"] = "@function.outer",
        },
      },
      move = {
        enable = true,
        disable = M.disable,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },

    playground = {
      enable = true,
      disable = M.disable,
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
    query_linter = {
      enable = true,
      disable = M.disable,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
    },
  })

  local wk = require("which-key")
  wk.register({ ["<leader>T"] = { "<cmd>TSBufToggle highlight<CR>", "Toggle treesitter highlights" } })

  require("treesitter-context").setup({
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
      -- For all filetypes
      -- Note that setting an entry here replaces all other patterns for this entry.
      -- By setting the 'default' entry below, you can control which nodes you want to
      -- appear in the context window.
      default = {
        "class",
        "function",
        "method",
        -- 'for', -- These won't appear in the context
        -- 'while',
        -- 'if',
        -- 'switch',
        -- 'case',
      },
      -- Example for a specific filetype.
      -- If a pattern is missing, *open a PR* so everyone can benefit.
      --   rust = {
      --       'impl_item',
      --   },
    },
    exact_patterns = {
      -- Example for a specific filetype with Lua patterns
      -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
      -- exactly match "impl_item" only)
      -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
    mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
    separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
  })

  wk.register({ ["<leader>C"] = { "<cmd>TSContextToggle<CR>", "Toggle treesitter context" } })
end

return M

local treesitter = require("nvim-treesitter.configs")

local M = {}

local disabled_filetypes = { "php", "html" }

function M.disable(lang, bufnr)
  return vim.tbl_contains(disabled_filetypes, lang)
    or (lang == "typescript" and vim.api.nvim_buf_line_count(bufnr) > 10000)
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
    enable = false,
    disable = M.disable,
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

return M

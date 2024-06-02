local M = {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},
}

function M.config()
  require("typescript-tools").setup({
    should_attach = function(bufnr)
      return not require("util").is_large_file(bufnr)
    end,

    on_attach = function(client, bufnr)
      require('config.plugins.lsp').attach(client, bufnr)

      require("which-key").register({
        name = "TypeScript Tools",
        prefix = "<leader>y",
        o = { "<cmd>TSToolsOrganizeImports<cr>", "Organize imports" },
        s = { "<cmd>TSToolsSortImports<cr>", "Sort imports" },
        u = { "<cmd>TSToolsRemoveUnusedImports<cr>", "Remove unused imports" },
        i = { "<cmd>TSToolsAddMissingImports<cr>", "Add missing imports" },
        f = { "<cmd>TSToolsFixAll<cr>", "Fix all fixable errors" },
        d = { "<cmd>TSToolsGoToSourceDefinition<cr>", "Go to source definition" },
        r = { "<cmd>TSToolsRenameFile<cr>", "Rename current file and update connected files" },
      }, { buffer = 0 })
    end,

    settings = {
      -- spawn additional tsserver instance to calculate diagnostics on it
      separate_diagnostic_server = true,
      -- "change"|"insert_leave" determine when the client asks the server about diagnostic
      publish_diagnostic_on = "insert_leave",
      -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
      -- "remove_unused_imports"|"organize_imports") -- or string "all"
      -- to include all supported code actions
      -- specify commands exposed as code_actions
      expose_as_code_action = {},
      -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
      -- not exists then standard path resolution strategy is applied
      tsserver_path = nil,
      -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
      -- (see 💅 `styled-components` support section)
      tsserver_plugins = {},
      -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
      -- memory limit in megabytes or "auto"(basically no limit)
      tsserver_max_memory = "auto",
      -- described below
      tsserver_format_options = {},
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      -- locale of all tsserver messages, supported locales you can find here:
      -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
      tsserver_locale = "en",
      -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
      complete_function_calls = false,
      include_completions_with_insert_text = true,
      -- CodeLens
      -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
      -- possible values: ("off"|"all"|"implementations_only"|"references_only")
      code_lens = "off",
      -- by default code lenses are displayed on all referencable values and for some of you it can
      -- be too much this option reduce count of them by removing member references from lenses
      disable_member_code_lens = true,
    },
  })
end


return M

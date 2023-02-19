-- Run functions on tree-sitter nodes and update buffer with the result.
-- Examples:
--    * Toggle multiline
--    * Toggle block (Ruby)
--    * Toggle hash style (Ruby)
--    * Toggle hash style (Ruby)
return {
  "ckolkey/ts-node-action",
  dependencies = { "nvim-treesitter", "tpope/vim-repeat" },
  config = function()
    local ts_node_action = require("ts-node-action")
    ts_node_action.setup({})

    vim.keymap.set({ "n" }, "<leader>A", ts_node_action.node_action, { desc = "Trigger Node Action" })

    -- Present available node actions for the node under the cursor
    -- alongside lsp/null-ls code actions.
    require("null-ls").register({
      name = "more_actions",
      method = { require("null-ls").methods.CODE_ACTION },
      filetypes = { "_all" },
      generator = { fn = require("ts-node-action").available_actions },
    })
  end,
}

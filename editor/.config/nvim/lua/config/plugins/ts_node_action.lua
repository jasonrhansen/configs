-- Run functions on tree-sitter nodes and update buffer with the result.
-- Examples:
--    * Toggle multiline
--    * Toggle block (Ruby)
--    * Toggle hash style (Ruby)
--    * Toggle hash style (Ruby)

local function multiline_method_chain(node)
  local helpers = require('ts-node-action.helpers')
  local replacement = {}

  for child in node:iter_children() do
    if child:type() == "call" then
      for _, r in ipairs(multiline_method_chain(child)) do
        table.insert(replacement, r)
      end
    else
      local node_text = helpers.node_text(child)
      if node_text == "."  or next(replacement) == nil then
        table.insert(replacement, node_text)
      else
        if node_text:sub(1, 1) == "{" then
          node_text = " " .. node_text
        end
        replacement[#replacement] = replacement[#replacement] .. node_text
      end
    end
  end

  return replacement, { cursor = {}, format = true }
end

return {
  "ckolkey/ts-node-action",
  dependencies = { "nvim-treesitter", "tpope/vim-repeat" },
  config = function()
    local ts_node_action = require("ts-node-action")
    ts_node_action.setup({
      ruby = {
        ['call'] = {
          { multiline_method_chain, "Multi-line method chain" },
        },
      },
    })

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

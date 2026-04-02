---@diagnostic disable: missing-fields
local M = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
}

function M.config()
  vim.keymap.set(
    { "n", "x", "o" },
    "<leader>tT",
    "<cmd>TSBufToggle highlight<CR>",
    { desc = "Toggle treesitter highlights" }
  )

  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local bufnr = args.buf
      local ft = vim.bo[bufnr].filetype

      -- 1. Get the language name for the filetype
      local lang = vim.treesitter.language.get_lang(ft) or ft

      -- 2. Check if a parser is actually installed for this language
      local has_parser = pcall(vim.treesitter.get_parser, bufnr, lang)

      -- 3. Only attempt to start if the parser exists
      if has_parser then
        -- Use pcall here too, just in case the parser is corrupted
        -- or the buffer is in an invalid state
        pcall(vim.treesitter.start, bufnr, lang)
      end
    end,
  })
end

return M

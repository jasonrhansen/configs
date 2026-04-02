local M = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
}

function M.config()
  local enable_highlights = function(lang)
    return not vim.tbl_contains({ "html" }, lang)
  end

  local enable_indent = function(lang)
    return not vim.tbl_contains({ "ruby", "rust" }, lang)
  end

  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local bufnr = args.buf
      local ft = vim.bo[bufnr].filetype
      local lang = vim.treesitter.language.get_lang(ft) or ft

      -- Check if a parser is actually installed for this language
      local has_parser = pcall(vim.treesitter.get_parser, bufnr, lang)

      -- Only attempt to start if the parser exists
      if has_parser then
        if enable_highlights(lang) then
          pcall(vim.treesitter.start, bufnr, lang)
        end

        if enable_indent(lang) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end
    end,
  })
end

return M

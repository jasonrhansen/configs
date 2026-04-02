local M = {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
}

function M.config()
	local default_no_highlight_langs = { "html" }

	vim.api.nvim_create_autocmd("FileType", {
		callback = function(args)
			local bufnr = args.buf
			local ft = vim.bo[bufnr].filetype
			local lang = vim.treesitter.language.get_lang(ft) or ft

			if vim.tbl_contains(default_no_highlight_langs, lang) then
				return
			end

			-- Check if a parser is actually installed for this language
			local has_parser = pcall(vim.treesitter.get_parser, bufnr, lang)

			-- Only attempt to start if the parser exists
			if has_parser then
				-- Use pcall here too, just in case the parser is corrupted
				-- or the buffer is in an invalid state
				pcall(vim.treesitter.start, bufnr, lang)
			end
		end,
	})
end

return M

-- Disable default mappings for closer and endwise so we can make them play well with compe.
vim.g.closer_no_mappings = false
vim.g.endwise_no_mappings = false

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.compeCR = function()
	if vim.fn.pumvisible() == 1 and vim.fn.complete_info()['selected'] ~= -1 then
		vim.fn['compe#confirm']('<CR>')
	else
    -- Call endwise and closer functions
		return t "<CR><Plug>DiscretionaryEnd<Plug>CloserClose"
	end
end

vim.api.nvim_set_keymap('i' , '<CR>', 'v:lua.compeCR()', {expr = true , silent = true})

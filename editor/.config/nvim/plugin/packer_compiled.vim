" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

lua << END
local plugins = {
  ["coc.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/jrhansen/.local/share/nvim/site/pack/packer/opt/coc.nvim"
  },
  ["completion-nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/jrhansen/.local/share/nvim/site/pack/packer/opt/completion-nvim"
  },
  ["csv.vim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/jrhansen/.local/share/nvim/site/pack/packer/opt/csv.vim"
  },
  ["lsp-status.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/jrhansen/.local/share/nvim/site/pack/packer/opt/lsp-status.nvim"
  },
  ["nvim-lspconfig"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/jrhansen/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/jrhansen/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/jrhansen/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  playground = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/jrhansen/.local/share/nvim/site/pack/packer/opt/playground"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/jrhansen/.local/share/nvim/site/pack/packer/opt/undotree"
  },
  ["vim-less"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/jrhansen/.local/share/nvim/site/pack/packer/opt/vim-less"
  },
  ["vim-swift"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/jrhansen/.local/share/nvim/site/pack/packer/opt/vim-swift"
  },
  ["vim-tmux"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/jrhansen/.local/share/nvim/site/pack/packer/opt/vim-tmux"
  }
}

local function handle_bufread(names)
  for _, name in ipairs(names) do
    local path = plugins[name].path
    for _, dir in ipairs({ 'ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin' }) do
      if #vim.fn.finddir(dir, path) > 0 then
        vim.cmd('doautocmd BufRead')
        return
      end
    end
  end
end

_packer_load = nil

local function handle_after(name, before)
  local plugin = plugins[name]
  plugin.load_after[before] = nil
  if next(plugin.load_after) == nil then
    _packer_load({name}, {})
  end
end

_packer_load = function(names, cause)
  local some_unloaded = false
  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      some_unloaded = true
      break
    end
  end

  if not some_unloaded then return end

  local fmt = string.format
  local del_cmds = {}
  local del_maps = {}
  for _, name in ipairs(names) do
    if plugins[name].commands then
      for _, cmd in ipairs(plugins[name].commands) do
        del_cmds[cmd] = true
      end
    end

    if plugins[name].keys then
      for _, key in ipairs(plugins[name].keys) do
        del_maps[key] = true
      end
    end
  end

  for cmd, _ in pairs(del_cmds) do
    vim.cmd('silent! delcommand ' .. cmd)
  end

  for key, _ in pairs(del_maps) do
    vim.cmd(fmt('silent! %sunmap %s', key[1], key[2]))
  end

  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      vim.cmd('packadd ' .. name)
      if plugins[name].config then
        for _i, config_line in ipairs(plugins[name].config) do
          loadstring(config_line)()
        end
      end

      if plugins[name].after then
        for _, after_name in ipairs(plugins[name].after) do
          handle_after(after_name, name)
          vim.cmd('redraw')
        end
      end

      plugins[name].loaded = true
    end
  end

  handle_bufread(names)

  if cause.cmd then
    local lines = cause.l1 == cause.l2 and '' or (cause.l1 .. ',' .. cause.l2)
    vim.cmd(fmt('%s%s%s %s', lines, cause.cmd, cause.bang, cause.args))
  elseif cause.keys then
    local keys = cause.keys
    local extra = ''
    while true do
      local c = vim.fn.getchar(0)
      if c == 0 then break end
      extra = extra .. vim.fn.nr2char(c)
    end

    if cause.prefix then
      local prefix = vim.v.count and vim.v.count or ''
      prefix = prefix .. '"' .. vim.v.register .. cause.prefix
      if vim.fn.mode('full') == 'no' then
        if vim.v.operator == 'c' then
          prefix = '' .. prefix
        end

        prefix = prefix .. vim.v.operator
      end

      vim.fn.feedkeys(prefix, 'n')
    end

    -- NOTE: I'm not sure if the below substitution is correct; it might correspond to the literal
    -- characters \<Plug> rather than the special <Plug> key.
    vim.fn.feedkeys(string.gsub(string.gsub(cause.keys, '^<Plug>', '\\<Plug>') .. extra, '<[cC][rR]>', '\r'))
  elseif cause.event then
    vim.cmd(fmt('doautocmd <nomodeline> %s', cause.event))
  elseif cause.ft then
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeplugin', cause.ft))
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeindent', cause.ft))
  end
end

-- Runtimepath customization

-- Pre-load configuration
-- Post-load configuration
-- Conditional loads
if
  loadstring("\27LJ\2\n$\0\0\2\0\1\0\0046\0\0\0B\0\1\2\19\0\0\0L\0\2\0\17Use_nvim_lsp\0")()
then
	vim.cmd("packadd coc.nvim")
end

if
  loadstring("\27LJ\2\n?\0\0\1\0\3\1\t6\0\0\0009\0\1\0009\0\2\0\b\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\17use_nvim_lsp\6g\bvim\2\0")()
then
	vim.cmd("packadd playground")
		vim.cmd("packadd completion-nvim")
		vim.cmd("packadd lsp-status.nvim")
		vim.cmd("packadd nvim-treesitter")
		vim.cmd("packadd nvim-lspconfig")
end

-- Load plugins in order defined by `after`
END

function! s:load(names, cause) abort
call luaeval('_packer_load(_A[1], _A[2])', [a:names, a:cause])
endfunction


" Command lazy-loads
command! -nargs=* -range -bang -complete=file UndotreeToggle call s:load(['undotree'], { "cmd": "UndotreeToggle", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })

" Keymap lazy-loads

augroup packer_load_aucmds
  au!
  " Filetype lazy-loads
  au FileType swift ++once call s:load(['vim-swift'], { "ft": "swift" })
  au FileType Less ++once call s:load(['vim-less'], { "ft": "Less" })
  au FileType tmux ++once call s:load(['vim-tmux'], { "ft": "tmux" })
  au FileType csv ++once call s:load(['csv.vim'], { "ft": "csv" })
  " Event lazy-loads
augroup END

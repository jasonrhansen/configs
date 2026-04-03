local util = require("util")
local require = util.require

require("config.globals")
require("config.options")
require("config.autocmds")
require("config.signs")

-- Load plugins
require("config.lazy")

require("config.commands")
require("config.theme")
require("config.relativize")
require("config.keymaps")

-- Add Cfilter command to filter the quickfix list.
vim.cmd.packadd("cfilter")

vim.cmd.packadd("nvim.undotree")

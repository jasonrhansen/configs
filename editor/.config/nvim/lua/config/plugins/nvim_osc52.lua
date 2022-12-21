-- Copy text to the system clipboard using the ANSI OSC52 sequence.
-- This is location-independent, including from remote SSH sessions.
local M = {
  "ojroques/nvim-osc52",
}

function M.config()
  -- Only use OSC52 for SSH sessions. No need to use locally.
  if os.getenv("SSH_CLIENT") == nil then
    return
  end

  local osc52 = require("osc52")

  osc52.setup({
    max_length = 0, -- Maximum length of selection (0 for no limit)
    silent = true, -- Disable message on successful copy
    trim = false, -- Trim text before copy
  })

  vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = "jason-config",
    callback = function(_)
      local operator = vim.v.event.operator
      local regname = vim.v.event.regname
      if operator == "y" and (regname == "" or regname == "+") then
        osc52.copy(vim.fn.getreg('"'))
      end
    end,
  })
end

return M

local source = {}
local rubocop_cache = nil

function source.new()
  return setmetatable({}, { __index = source })
end

local function fetch_rules(callback)
  if rubocop_cache then
    callback(rubocop_cache)
    return
  end

  vim.system({ "rubocop", "--show-cops" }, { text = true }, function(obj)
    if obj.code ~= 0 then
      vim.schedule(function()
        callback({})
      end)
      return
    end

    local rules = {}
    for rule in obj.stdout:gmatch("\n([%w%d/]+):") do
      table.insert(rules, {
        label = rule,
        kind = 12, -- Keyword kind
        detail = "[RuboCop]",
        insertText = rule,
      })
    end

    rubocop_cache = rules
    vim.schedule(function()
      callback(rules)
    end)
  end)
end

function source:get_completions(_context, callback)
  fetch_rules(function(rules)
    callback({
      is_incomplete = false,
      items = rules,
    })
  end)
  -- Cancelation function
  return function() end
end

return source

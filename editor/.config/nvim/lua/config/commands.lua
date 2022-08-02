vim.api.nvim_create_user_command("BufOnly", '%bdelete|edit #|normal `"', {})

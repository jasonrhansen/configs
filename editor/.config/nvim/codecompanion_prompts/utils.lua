return {
  git_diff_staged = function()
    return vim.system({ "git", "diff", "--no-ext-diff", "--staged" }, { text = true }):wait().stdout
  end,
}

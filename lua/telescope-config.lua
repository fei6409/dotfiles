-- Inspired by https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
-- If in a git project directory, find_files() will start from the git root.
local function is_git_repo()
  vim.fn.system("git rev-parse --is-inside-work-tree")
  return vim.v.shell_error == 0
end

local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

local M = {}

M.project_files = function()
  local opts = {}

  if is_git_repo() then
    opts = { cwd=get_git_root() }
  end
  require('telescope.builtin').find_files(opts)
end

return M

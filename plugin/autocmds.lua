local api = vim.api

api.nvim_create_autocmd(
  "VimEnter",
  { command = [[:Dashboard]]}
)

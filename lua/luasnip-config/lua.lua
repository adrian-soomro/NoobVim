local M = {}

local function get_snippets(ls, fmt, rep)
  local s, i = ls.s, ls.insert_node
  return {
    s("req", fmt(
      [[
      local {} = require('{}')
      {}
    ]],
      { i(1, "module"), rep(1), i(0) }))
  }
end

function M.setup_snippets(ls, fmt, rep)
  local snippets = get_snippets(ls, fmt, rep)

  ls.add_snippets("lua", snippets)
end

return M

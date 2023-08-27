local M = {}

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local function get_snippets(ls)
  local s, i, f = ls.s, ls.insert_node, ls.function_node
  return {
    s("req", fmt(
      [[
        local {} = require('{}')
        {}
      ]],
      { i(1, "module"), rep(1), i(0) })),
    s("req safe", fmt(
      [[
        local {}_status_ok, {} = pcall(require, '{}')
        if not {}_status_ok then
          print("Error importing {} located in {}")
          return
        end
        {}
      ]],
      { i(1, "module_name"),
        rep(1),
        i(2, "path_to_module"),
        rep(1),
        rep(1),
        f(function(_, snip)
          return snip.env.TM_FILENAME
        end, {}),
        i(0)
      })),
  }
end

function M.setup_snippets(ls)
  local snippets = get_snippets(ls)

  ls.add_snippets("lua", snippets)
end

return M

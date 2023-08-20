local ls = require("luasnip")

local s, i, t, c = ls.s, ls.insert_node, ls.text_node, ls.choice_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("lua", {
  s("req", fmt(
    [[
      local {} = require('{}')
      {}
    ]],
    { i(1, "module"), rep(1), i(0) }))
  -- add one for js functions
})

ls.add_snippets("js", {
  -- if first in the file, do a nested one with it inside.
  s("desc", fmt(
    [[
      describe('{}', () => {{
        {}
      }})
    ]],
    { i(1, "$TM_FILEBASE_NAME"), i(2) }))
})

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
}

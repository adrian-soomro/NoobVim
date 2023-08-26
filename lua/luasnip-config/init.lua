local ls = require("luasnip")

local s, i = ls.s, ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local js_snippets = {
  s("fn", fmt(
    [[
      const {} = ({}) => {{
        {}
      }}
    ]],
    { i(1, "functionName"), i(2, "param1..."), i(0) })),
  s("fn async", fmt(
    [[
      const {} = async ({}) => {{
        {}
      }}
    ]],
    { i(1, "functionName"), i(2, "param1..."), i(0) })),
  s("map", fmt(
    [[
      {}.map(({}) => {{
        {}
      }})
    ]],
    { i(1, "iterable"), i(2, "element"), i(0) })),
  s("filter", fmt(
    [[
      {}.filter(({}) => {{
        {}
      }})
    ]],
    { i(1, "iterable"), i(2, "element"), i(0) })),
  s("desc", fmt(
    [[
      describe('{}', () => {{
        {}
      }})
    ]],
    { i(1), i(0) })),
  s("it", fmt(
    [[
      it('{}', () => {{
        {}
      }})
    ]],
    { i(1), i(0) })),
  s("it async", fmt(
    [[
      it('{}', async () => {{
        {}
      }})
    ]],
    { i(1), i(0) }))
}

ls.add_snippets("lua", {
  s("req", fmt(
    [[
      local {} = require('{}')
      {}
    ]],
    { i(1, "module"), rep(1), i(0) }))
})

ls.add_snippets("javascript", js_snippets)
ls.add_snippets("typescript", js_snippets)
ls.add_snippets("svelte", js_snippets)

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
}

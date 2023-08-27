local M = {}

local function get_snippets(ls, fmt)
  local s, i = ls.s, ls.insert_node
  return {
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
end

function M.setup_snippets(ls, fmt)
  local snippets = get_snippets(ls, fmt)

  ls.add_snippets("javascript", snippets)
  ls.add_snippets("typescript", snippets)
  ls.add_snippets("svelte", snippets)
end

return M

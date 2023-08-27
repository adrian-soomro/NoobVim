local ls_status_ok, ls = pcall(require, 'luasnip')
if not ls_status_ok then
  print("Error importing luasnip")
  return
end

local lua_snippets_status_ok, lua_snippets = pcall(require, 'luasnip-config/lua')
if not lua_snippets_status_ok then
  print("Error importing lua snippets")
  return
end

local js_snippets_status_ok, js_snippets = pcall(require, 'luasnip-config/js')
if not js_snippets_status_ok then
  print("Error importing js snippets")
  return
end

lua_snippets.setup_snippets(ls)

js_snippets.setup_snippets(ls)
js_snippets.setup_snippets(ls)
js_snippets.setup_snippets(ls)

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
}

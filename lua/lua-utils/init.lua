local M = {}

function M.merge(...)
  local result = {}
  for _, table in ipairs { ... } do
    for key, value in pairs(table) do
      result[key] = value
    end
    local meta_table = getmetatable(table)
    if meta_table then
      setmetatable(result, meta_table)
    end
  end
  return result
end

return M

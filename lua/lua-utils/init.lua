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

function M.list_dir(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -a "' .. directory .. '"')
  if (pfile ~= nil) then
    for filename in pfile:lines() do
      if (filename ~= "." and filename ~= "..") then
        i = i + 1
        t[i] = filename
      end
    end
    pfile:close()
  end
  return t
end

function M.has_value(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

function M.get_file_extension(url)
  return url:match("^.+(%..+)$"):sub(2)
end

return M

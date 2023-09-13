local utils = require('lua-utils')

local M = {}

local function get_path_to_skeleton_directory()
  local directory_of_current_file = debug.getinfo(2, "S").source:sub(2):match("(.*/)")
  return directory_of_current_file .. "skeletons"
end

local function get_skeleton_file_contents(extension)
  local path_to_skeleton_file = get_path_to_skeleton_directory() .. "/" .. extension .. ".skeleton"

  local skeleton_file = io.open(path_to_skeleton_file, "rb")
  if (skeleton_file ~= nil) then
    return skeleton_file:read("*all")
  end
  print("[file-skeleton-config] there was a problem loading skeleton file contents for '" .. extension "' extension.")
  return ""
end

function M.insert_skeleton(file_path)
  local extension = utils.get_file_extension(file_path)

  local supported_extensions = utils.list_dir(get_path_to_skeleton_directory())
  if not utils.has_value(supported_extensions, extension .. ".skeleton") then
    return
  end

  local newly_created_file = io.open(file_path, "w")
  if (newly_created_file ~= nil) then
    newly_created_file:write(get_skeleton_file_contents(extension))
    newly_created_file:close()
  end
end

return M

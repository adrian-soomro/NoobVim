require('bufferline').setup({
  animation = true,
  auto_hide = false,
  tabpages = true,
  closable = true,
  clickable = true,
  icons = {
    buffer_index = true,
    filetype = { enabled = true },
    sepatarator = { left = '▎' },
    inactive = { sepatarator = { left = '▎' } },
    button = '',
    pinned = { button = '' },
    modified = { button = '●' }
  },
  insert_at_end = true,
})

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

-- nvim tree integration (buffer offset)
local nvim_tree_events = require('nvim-tree.events')
local bufferline_state = require('bufferline.api')

local function get_tree_size()
  return require 'nvim-tree.view'.View.width
end

nvim_tree_events.subscribe('TreeOpen', function()
  bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('Resize', function()
  bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('TreeClose', function()
  bufferline_state.set_offset(0)
end)

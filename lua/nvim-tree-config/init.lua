local wk = require('which-key')
local nt_api = require('nvim-tree.api')
local file_skeleton_utils = require('file-skeleton-config')

local function bulk_delete()
  local marked_files = nt_api.marks.list()
  for _, value in pairs(marked_files) do
    os.execute("rm -rf " .. value.absolute_path)
  end
end

local setup_key_mapping = function(bufnr)
  local leader_mapping = {
    g = {
      name = "Go to",
      d = { nt_api.tree.change_root_to_node, "directory under cursor" },
      p = { nt_api.node.navigate.parent, "Move cursor to the parent directory" },
    },
  }

  local mapping = {
    o = { nt_api.node.open.edit, "Open file/directory" },
    ['<CR>'] = { nt_api.node.open.edit, "Open file/directory" },
    ['<2-LeftMouse>'] = { nt_api.node.open.edit, "Open file/directory" },
    l = { nt_api.node.open.edit, "Open file/directory" },
    ['<C-t>'] = { nt_api.node.open.tab, "Open file in new tab" },
    ['<C-k>'] = { nt_api.node.open.show_info_popup, "Toggle file info popup" },
    a = { nt_api.fs.create, "Add a file or directory/" },
    d = { nt_api.fs.remove, "Delete a file or directory/" },
    D = { nt_api.fs.trash, "Trash a file" },
    r = { nt_api.fs.rename, "Rename a file" },
    c = { nt_api.fs.copy.node, "Copy a file" },
    y = { nt_api.fs.copy.filename, "Yank a file's name" },
    Y = { nt_api.fs.copy.relative, "Yank a file's relative path" },
    Ya = { nt_api.fs.copy.absolute, "Yank a file's absolute path" },
    p = { nt_api.fs.paste, "Paste" },
    q = { nt_api.tree.close, "Close File Tree" },
    v = { nt_api.node.open.vertical, "Open file in vertical split" },
    m = { nt_api.marks.toggle, "Mark a file for moving" },
    b = {
      m = { nt_api.marks.bulk.move, "Move marked files" },
      d = { bulk_delete, "Delete marked files" },
    },
  }

  local leader_opts = {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  }

  local opts = {
    mode = "n",     -- NORMAL mode
    prefix = "",
    buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  }

  wk.register(leader_mapping, leader_opts)
  wk.register(mapping, opts)
end

local function open_nvim_tree(data)
  local ignored_file_types = {
    "dashboard",
    "DiffviewFiles"
  }
  -- buffer is a real file on the disk
  local real_file = vim.fn.filereadable(data.file) == 1

  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  local file_type = vim.bo[data.buf].ft

  if vim.g.noobvim_tree_was_shown then
    return
  end

  if not real_file and no_name then
    return
  end

  if vim.tbl_contains(ignored_file_types, file_type) then
    return
  end

  require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })

  vim.g.noobvim_tree_was_shown = true
end

require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,
  on_attach = setup_key_mapping,
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
    show_on_dirs = true
  },
  sort_by = "case_sensitive",
  view = {
    width = 30,
    number = false,
    relativenumber = false,
    adaptive_size = true,
  },
  renderer = {
    group_empty = true,
    icons = {
      webdev_colors = true,
      git_placement = "before",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true
      },
      glyphs = {
        git = {
          unstaged = "●",
          staged = "S",
          ignored = "󰗹",
          deleted = "D",
          untracked = "●",
          renamed = "➜",
        }
      }
    }
  },
  update_focused_file = {
    enable = true,
    update_root = true,
    ignore_list = {},
  },
  filters = {
    dotfiles = false,
  },
})

require('nvim-web-devicons').setup {
  default = true
}

vim.api.nvim_create_autocmd({ "BufAdd" }, { callback = open_nvim_tree })

nt_api.events.subscribe(nt_api.events.Event.FileCreated, function(data)
  file_skeleton_utils.insert_skeleton(data.fname)
end)

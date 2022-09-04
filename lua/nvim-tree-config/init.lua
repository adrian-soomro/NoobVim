require("nvim-tree").setup({
  open_on_setup = true,
  ignore_ft_on_setup = { 'dashboard' },
  disable_netrw = true,
  hijack_netrw = true,
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
    show_on_dirs = true
  },
  sort_by = "case_sensitive",
  view = {
    width = 30,
    height = 30,
    number = false,
    relativenumber = false,
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = "h", action = "close_node" },
        { key = "v", action = "vsplit" },
      },
    },
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
          ignored = "﫸",
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

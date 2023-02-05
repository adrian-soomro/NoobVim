require('lspsaga').setup({
  finder = {
    edit = { "o", "<cr>" },
    vsplit = "v",
    split = "i",
    tabe = "t",
    quit = { "q", "<esc>" },
  },
  code_action = {
    num_shortcut = true,
    keys = {
      quit = { "q", "<esc>" },
      exec = "<cr>"
    }
  },
  diagnostic = {
    show_code_action = true,
    show_source = true,
    jump_num_shortcut = true,
    custom_fix = nil,
    custom_msg = nil,
    keys = {
      exec_action = { "o", "<cr>" },
      quit = { "q", "<esc>" },
      go_action = "g"
    },
  },
  rename = {
    quit = { "q", "<esc>" },
    exec = "<CR>",
    mark = "x",
    confirm = "<CR>",
    in_select = true,
  },
  outline = {
    keys = {
      jump = "o",
      expand_collapse = "u",
      quit = "<esc>" ,
    },
  },
  symbol_in_winbar = {
    enable = true,
    separator = "  ",
    hide_keyword = true,
    show_file = true,
    folder_level = 2,
    respect_root = false,
    color_mode = true,
  },
})

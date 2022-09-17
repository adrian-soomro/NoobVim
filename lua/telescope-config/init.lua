local telescope = require('telescope')

telescope.setup {
  defaults = {
    file_ignore_patterns = { ".local/", ".nvm" }
  }
}

telescope.load_extension('fzf')
telescope.load_extension('neoclip')
telescope.load_extension('dap')
telescope.load_extension('repo')

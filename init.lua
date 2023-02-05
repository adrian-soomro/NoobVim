require('packer-config')
require('telescope-config')
require('tree-sitter-config')
require('lsp-config')
require('color-schemes')
require('nvim-tree-config')
require('nvim-cmp-config')
require('toggle-term-config')
require('gitsigns-config')
require('neoclip-config')
require('barbar-config')
require('lspsaga-config')
require('autopairs-config')
require('whichkey-config')
require('dap-config')
require('diffview-config')
require('settings')

vim.api.nvim_set_var('noobvim', {
  tree = {
    was_shown = false
  }
})

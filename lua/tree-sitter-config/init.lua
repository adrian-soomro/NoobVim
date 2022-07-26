require('nvim-treesitter.configs').setup {
  ensure_installed = { "bash", "css", "dockerfile", "go", "graphql", "hcl", "html", "http", "java", "javascript", "json", "lua", "markdown", "python", "scss", "sql", "typescript", "yaml", "c_sharp" },
  sync_install = false,
  highlight = {
    enable = true,
    disable = { },
    additional_vim_regex_highlighting = false,
  },
  playground = {
    enable = true
  }
}

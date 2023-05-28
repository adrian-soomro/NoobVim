local lsp_flags = {
  debounce_text_changes = 150,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require 'lspconfig'.lua_ls.setup {
  flags = lsp_flags,
  capabilities = capabilities,
}

require('lspconfig').bashls.setup {
  flags = lsp_flags,
  capabilities = capabilities,
}

require('lspconfig').tsserver.setup {
  flags = lsp_flags,
  capabilities = capabilities,
}

require('lspconfig').marksman.setup {
  flags = lsp_flags,
  capabilities = capabilities,
}

require('lspconfig').dockerls.setup {
  flags = lsp_flags,
  capabilities = capabilities,
}

require('lspconfig').terraformls.setup {
  flags = lsp_flags,
  capabilities = capabilities,
  cmd = { 'terraform-ls', 'serve' }
}

-- can support snippets, but needs enabling
require('lspconfig').jsonls.setup {
  flags = lsp_flags,
  capabilities = capabilities,
}

require('lspconfig').csharp_ls.setup {
  flags = lsp_flags,
  capabilities = capabilities,
}

require('lspconfig').pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 100
        }
      }
    }
  }
}

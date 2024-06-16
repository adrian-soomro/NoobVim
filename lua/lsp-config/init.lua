local capabilities = require('cmp_nvim_lsp').default_capabilities()
local util = require 'lspconfig/util'

local lsp_flags = {
  debounce_text_changes = 150,
}

--Enable (broadcasting) snippet capability for completion
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end
    })
  end
end
require 'lspconfig'.lua_ls.setup {
  flags = lsp_flags,
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').bashls.setup {
  flags = lsp_flags,
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').tsserver.setup {
  flags = lsp_flags,
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').marksman.setup {
  flags = lsp_flags,
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').dockerls.setup {
  flags = lsp_flags,
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').terraformls.setup {
  flags = lsp_flags,
  capabilities = capabilities,
  cmd = { 'terraform-ls', 'serve' },
  on_attach = on_attach
}

-- can support snippets, but needs enabling
require('lspconfig').jsonls.setup {
  flags = lsp_flags,
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').omnisharp.setup {
  flags = lsp_flags,
  capabilities = capabilities,
  cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
  enable_import_completion = true,
  organize_imports_on_format = true,
  enable_roslyn_analyzers = true,
  root_dir= util.root_pattern("*.sln", "*.csproj", "omnisharp.json", "function.json", ".vsconfig"),
  on_attach = on_attach
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
  },
  on_attach = on_attach
}

require('lspconfig').html.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').cssls.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').svelte.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

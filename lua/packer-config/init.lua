local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer = require('packer')

packer.init({
  snapshot = "packer.lock",
  snapshot_path = vim.fn.stdpath('config')
})

return packer.startup({
  function()
    use 'wbthomason/packer.nvim'
    use 'EdenEast/nightfox.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-treesitter/playground'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'lewis6991/gitsigns.nvim'
    use 'windwp/nvim-autopairs'
    use 'folke/which-key.nvim'
    use 'mfussenegger/nvim-dap'
    use 'nvim-telescope/telescope-dap.nvim'
    use 'cljoly/telescope-repo.nvim'
    use {
      'glepnir/dashboard-nvim',
      event = 'VimEnter',
      config = function()
        require('dashboard-config')
      end,
      requires = { 'nvim-tree/nvim-web-devicons' }
    }
    use {
      'sindrets/diffview.nvim',
      requires = 'nvim-lua/plenary.nvim'
    }
    use {
      'rcarriga/nvim-dap-ui',
      requires = { 'mfussenegger/nvim-dap' }
    }
    use {
      'ellisonleao/glow.nvim',
      config = function()
        require('glow').setup({
          glow_install_path = "/usr/bin" -- might end up somewhere else depending on the os
        })
      end
    }
    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run =
      'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }
    use {
      'nvim-tree/nvim-tree.lua',
      requires = { 'nvim-tree/nvim-web-devicons' }
    }
    use {
      'romgrk/barbar.nvim',
      requires = { 'nvim-tree/nvim-web-devicons' }
    }
    use {
      'akinsho/toggleterm.nvim', tag = 'v2.*'
    }
    use {
      'AckslD/nvim-neoclip.lua',
      requires = {
        'nvim-telescope/telescope.nvim'
      }
    }
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true },
      config = function()
        require('lualine').setup({
          options = { theme = 'dracula' }
        })
      end
    }
    use {
      'glepnir/lspsaga.nvim',
      branch = "main",
      requires = {
        "nvim-tree/nvim-web-devicons",
        "nvim-lspconfig"
      }
    }
    use {
      'folke/persistence.nvim',
      event = "BufReadPre",
      module = "persistence",
      config = function()
        require("persistence").setup()
      end
    }
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }
    use {
      'CRAG666/code_runner.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('code_runner').setup({
          mode = 'term',
          focus = false,
          -- put here the commands by filetype
          filetype = {
            java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
            python = "python3 -u",
            typescript = "node $file",
            javascript = "node $file",
            rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
          }
        })
      end }
    use {
      'mxsdev/nvim-dap-vscode-js',
      requires = { "mfussenegger/nvim-dap" },
    }
    use {
      'theHamsta/nvim-dap-virtual-text',
      config = function()
        require('nvim-dap-virtual-text').setup({})
      end
    }
    use {
      'williamboman/mason.nvim',
      config = function()
        require('mason').setup({})
      end
    }
    use {
      'williamboman/mason-lspconfig.nvim',
      requires = { "williamboman/mason.nvim" },
      config = function()
        require('mason-lspconfig').setup({
          ensure_installed = { "bashls", "omnisharp", "cssls", "cucumber_language_server", "dockerls",
            "docker_compose_language_service", "eslint", "graphql", "html", "helm_ls", "jsonls", "jdtls", "tsserver",
            "lua_ls", "marksman", "powershell_es", "pylsp", "rust_analyzer", "sqls", "svelte", "taplo", "terraformls", "tflint",
            "vuels", "lemminx", "yamlls" },
          automatic_installation = true
        })
      end
    }
    use 'neovim/nvim-lspconfig'
    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = { snapshot = 'packer.lock' }
})

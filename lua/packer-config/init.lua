return require 'packer'.startup(function()
  use 'wbthomason/packer.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'neovim/nvim-lspconfig'
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
  use 'glepnir/dashboard-nvim'
  use 'folke/which-key.nvim'
  use 'mfussenegger/nvim-dap'
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
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use {
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
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
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup({
        options = { theme = 'dracula' }
      })
    end
  }
  use {
    'glepnir/lspsaga.nvim',
    branch = "main",
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
        mode = 'float',
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
    'microsoft/vscode-js-debug',
    opt = true,
    run = "npm install --legacy-peer-deps && npm run compile"
  }
end)

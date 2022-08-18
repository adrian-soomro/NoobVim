return require'packer'.startup(function()
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
  use {
    'ellisonleao/glow.nvim',
    config = function ()
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
    'windwp/nvim-autopairs',
    config = function ()
      require('nvim-autopairs').setup({})
    end
  }
end)

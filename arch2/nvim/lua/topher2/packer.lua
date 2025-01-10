-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	-- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
}
  use ({
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  config = function()
		  vim.cmd('colorscheme rose-pine')

	  end
  })

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  use('theprimeagen/harpoon')
  use('vim-airline/vim-airline')
  use('vim-airline/vim-airline-themes')
  use('tpope/vim-surround')

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
		  --- Uncomment these if you want to manage the language servers from neovim
		  -- {'williamboman/mason.nvim'},
		  -- {'williamboman/mason-lspconfig.nvim'},

		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'L3MON4D3/LuaSnip'},
	  }
}

  use('neovim/nvim-lspconfig')
  use('williamboman/mason.nvim')
  use('williamboman/mason-lspconfig.nvim')
  use('rafamadriz/friendly-snippets')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('saadparwaiz1/cmp_luasnip')
  use('hrsh7th/cmp-nvim-lua')

end)

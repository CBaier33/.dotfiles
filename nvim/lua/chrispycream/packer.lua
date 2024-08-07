-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  
  use 'eandrju/cellular-automaton.nvim'

  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	-- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
}

--   use {
--     'nvim-lualine/lualine.nvim',
--     requires = { 'nvim-tree/nvim-web-devicons', opt = true }
--   }

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('liuchengxu/graphviz.vim')
  use('theprimeagen/harpoon')
  use('https://github.com/preservim/nerdtree') -- NerdTree
  use('https://github.com/ryanoasis/vim-devicons') -- Developer Icons
  use('vim-airline/vim-airline')
  use('vim-airline/vim-airline-themes')
  use('tpope/vim-surround')
  use('alvan/vim-closetag') 
  use('jiangmiao/auto-pairs')
  use('shime/vim-livedown')
  use('nametake/golangci-lint-langserver')
  use('tanvirtin/monokai.nvim', {run = ':TransparentEnable'}) --colorscheme
  use('xiyaowong/transparent.nvim')

  -- install without yarn or npm
  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })


  use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  requires = {
    --- Uncomment these if you want to manage the language servers from neovim
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- LSP Support
    {'neovim/nvim-lspconfig'},
    -- Autocompletion
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},
  }
}

  use('neovim/nvim-lspconfig')
  use('rafamadriz/friendly-snippets')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('saadparwaiz1/cmp_luasnip')
  use('hrsh7th/cmp-nvim-lua')

end)

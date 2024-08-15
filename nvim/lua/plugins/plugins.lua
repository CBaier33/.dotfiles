return {

  -- BASIC SETUP 
  "vim-airline/vim-airline", -- vim airline
  "vim-airline/vim-airline-themes", -- airline themes
  "preservim/nerdtree", -- NerdTree
  
  "tpope/vim-surround", -- Parenthese completion
  "alvan/vim-closetag",
  "jiangmiao/auto-pairs",
  "xiyaowong/transparent.nvim",

  -- COLORSCHEME
  "tanvirtin/monokai.nvim", --colorscheme

  -- LSP
  {"nvim-treesitter/nvim-treesitter", opts = {auto_install = true, sync_install = false}},
  "nvim-telescope/telescope.nvim",

  {'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
 
}

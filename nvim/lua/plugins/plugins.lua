local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug 'vim-airline/vim-airline' -- vim airline
Plug 'vim-airline/vim-airline-themes' -- airline themes
Plug 'preservim/nerdtree' -- NerdTree
Plug 'tpope/vim-surround' -- Parenthese completion
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'

Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.8' })
Plug 'theprimeagen/harpoon'

Plug('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
Plug('VonHeikemen/lsp-zero.nvim', {['branch']= 'v3.x'})
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'

Plug('iamcco/markdown-preview.nvim', { ['do'] = function() -- Markdown Previews
  vim.fn['mkdp#util#install()']()
end, ['for'] = 'markdown'})
-- Need to run ":call mkdp#util#install()" within a markdown file to work correctly.
 
Plug 'xiyaowong/transparent.nvim' -- Transparant Backgrounds
Plug 'tanvirtin/monokai.nvim' --colorscheme

Plug 'nametake/golangci-lint-langserver'

vim.call('plug#end')

vim.cmd('silent! TransparentEnable') -- Enable Transparency on startup

---@diagnostic disable: undefined-global
-- Christopher's neovim config

-- Bootstrap lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

--
-- Options
--

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.guicursor = "a:block-blinkon0"
vim.opt.hlsearch = false
vim.opt.cursorline = true
vim.opt.winborder = "rounded"
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.cmd [[hi CursorLine guibg=#2a2a2a]]

--
-- Keymaps
--

-- file tree
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- quickly move selection
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-f>", ":NERDTreeToggle<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Copy Paste
vim.keymap.set("n", "<leader>n", ":tabn<CR>") -- switch tabs
vim.keymap.set("n", "<leader>y", '"+yy') -- copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y') -- copy selection to clipboard
vim.keymap.set("n", "<leader>p", '"+p') -- paste clipboard content


-- Normal mode window navigation
vim.keymap.set('n', '<A-h>', '<C-w>h', opts)
vim.keymap.set('n', '<A-j>', '<C-w>j', opts)
vim.keymap.set('n', '<A-k>', '<C-w>k', opts)
vim.keymap.set('n', '<A-l>', '<C-w>l', opts)

-- Insert mode window navigation (exit insert mode first)
vim.keymap.set('i', '<A-h>', '<C-\\><C-N><C-w>h', opts)
vim.keymap.set('i', '<A-j>', '<C-\\><C-N><C-w>j', opts)
vim.keymap.set('i', '<A-k>', '<C-\\><C-N><C-w>k', opts)
vim.keymap.set('i', '<A-l>', '<C-\\><C-N><C-w>l', opts)

-- Terminal mode window navigation (exit terminal mode first)
vim.keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h', opts)
vim.keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j', opts)
vim.keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k', opts)
vim.keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l', opts)

-- blazingly fast
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("i", "jk", "<Esc>ll")
vim.keymap.set("n", "<leader>b", ":TransparentToggle<CR>")
vim.keymap.set("n", ";", ":")

require("lazy").setup({
  spec = {
    {'echasnovski/mini.pick', version='*'},
    {'vim-airline/vim-airline'},
    {'vim-airline/vim-airline-themes'},
    {'preservim/nerdtree'},
    {'tpope/vim-surround'},
    {'alvan/vim-closetag'},
    {'jiangmiao/auto-pairs'},
    {'namrabtw/rusty.nvim'},

    {'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },

    {'theprimeagen/harpoon'},

    {'xiyaowong/transparent.nvim',
      config = function()
        require("transparent").setup({
          enable = true,
          extra_groups = {},
        })
      end,
    },

    {'tanvirtin/monokai.nvim'},
    {'rebelot/kanagawa.nvim'},
    {'EdenEast/nightfox.nvim'},

    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      build = "cd app && yarn install",
      init = function()
        vim.g.mkdp_filetypes = { "markdown" }
      end,
      ft = { "markdown" },
    },

    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v4.x',
      lazy = true,
      config = false,
    },

    {
      'williamboman/mason.nvim',
      lazy = false,
      config = true,
    },

    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        {'L3MON4D3/LuaSnip'},
      },
      config = function()
        local cmp = require('cmp')
        cmp.setup({
          sources = {
            {name = 'nvim_lsp'},
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
          }),
          snippet = {
            expand = function(args)
              vim.snippet.expand(args.body)
            end,
          },
        })
      end,
    },

    {
      'neovim/nvim-lspconfig',
      cmd = {'LspInfo', 'LspInstall', 'LspStart'},
      event = {'BufReadPre', 'BufNewFile'},
      dependencies = {
        {'hrsh7th/cmp-nvim-lsp'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
      },
      config = function()
        local lsp_zero = require('lsp-zero')

        local lsp_attach = function(client, bufnr)
          local opts = {buffer = bufnr}
          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<leader>o', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
          vim.keymap.set('n', '<leader>e', function()
            vim.diagnostic.open_float(nil, { focus = true, border = 'rounded' })
          end, { desc = "Show diagnostic under cursor" })
        end

        lsp_zero.extend_lspconfig({
          sign_text = true,
          lsp_attach = lsp_attach,
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })

        require('mason-lspconfig').setup({
          ensure_installed = {},
          handlers = {
            function(server_name)
              require('lspconfig')[server_name].setup({})
            end,
          },
        })
      end,
    },

    --{
    --  "nvim-treesitter/nvim-treesitter",
    --  config = function()
    --    local configs = require("nvim-treesitter.configs")
    --    configs.setup({
    --      auto_install = true,
    --      indent = { enable = true },
    --    })
    --  end,
    --},
  },

  install = { colorscheme = { "carbonfox"} },
  checker = { enabled = true },
})

require "mini.pick".setup()

-- Colorscheme
vim.cmd.colorscheme("retrobox")
vim.cmd("AirlineTheme base16_gruvbox_dark_pale")


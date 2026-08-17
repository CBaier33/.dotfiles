-- Christopher's Neovim config
-- Requires Neovim 0.12+
-- Uses Neovim's built-in vim.pack package manager.

vim.g.mapleader = " "

---------------------------------------------------------------------------
-- Plugin management
---------------------------------------------------------------------------

local gh = function(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  -- General
  gh("echasnovski/mini.pick"),
  gh("vim-airline/vim-airline"),
  gh("vim-airline/vim-airline-themes"),
  gh("tpope/vim-surround"),
  gh("alvan/vim-closetag"),
  gh("jiangmiao/auto-pairs"),
  gh("namrabtw/rusty.nvim"),

  -- Telescope
  {
    src = gh("nvim-telescope/telescope.nvim"),
    version = "0.1.8",
  },
  gh("nvim-lua/plenary.nvim"),

  -- Harpoon
  gh("ThePrimeagen/harpoon"),

  -- Transparent
  gh("xiyaowong/transparent.nvim"),

  -- Colorschemes
  gh("tanvirtin/monokai.nvim"),
  gh("rebelot/kanagawa.nvim"),
  gh("EdenEast/nightfox.nvim"),

  -- Markdown preview
  gh("iamcco/markdown-preview.nvim"),

  -- Completion
  gh("hrsh7th/nvim-cmp"),
  gh("hrsh7th/cmp-nvim-lsp"),
  gh("L3MON4D3/LuaSnip"),

  -- LSP
  gh("neovim/nvim-lspconfig"),
  gh("williamboman/mason.nvim"),
  gh("williamboman/mason-lspconfig.nvim"),

  -- Flutter
  gh("nvim-flutter/flutter-tools.nvim"),
  gh("stevearc/dressing.nvim"),

  -- Treesitter
  gh("nvim-treesitter/nvim-treesitter"),
})

---------------------------------------------------------------------------
-- Plugin configuration
---------------------------------------------------------------------------

-- Transparent.nvim
require("transparent").setup({
  enable = true,
  extra_groups = {},
})

-- mini.pick
require("mini.pick").setup()

-- Flutter
require("flutter-tools").setup({})

-- Markdown Preview
vim.g.mkdp_filetypes = { "markdown" }

-- Markdown Preview build after install/update.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local spec = ev.data.spec
    local kind = ev.data.kind

    if spec.name == "markdown-preview.nvim"
        and (kind == "install" or kind == "update") then
      vim.system(
        { "yarn", "install" },
        {
          cwd = ev.data.path .. "/app",
          text = true,
        }
      )
    end
  end,
})

---------------------------------------------------------------------------
-- Options
---------------------------------------------------------------------------

vim.opt.number = true
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

vim.cmd([[hi CursorLine guibg=#2a2a2a]])

---------------------------------------------------------------------------
-- Keymaps
---------------------------------------------------------------------------

local map = vim.keymap.set

---------------------------------------------------------------------------
-- File tree / explorer
---------------------------------------------------------------------------

map("n", "<leader>pv", vim.cmd.Ex)
map("n", "<leader>pn", vim.cmd.Vex)

---------------------------------------------------------------------------
-- Visual mode movement
---------------------------------------------------------------------------

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

---------------------------------------------------------------------------
-- Scrolling
---------------------------------------------------------------------------

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

---------------------------------------------------------------------------
-- Tabs
---------------------------------------------------------------------------

map("n", "<leader>t", ":tabnew<CR>:Ex<CR>")
map("n", "<leader>n", ":tabn<CR>")
map("n", "<leader>p", ":tabp<CR>")

---------------------------------------------------------------------------
-- Clipboard
---------------------------------------------------------------------------

map("n", "<leader>y", '"+yy')
map("v", "<leader>y", '"+y')
map("n", "<leader>p", '"+p')

---------------------------------------------------------------------------
-- Normal mode window navigation
---------------------------------------------------------------------------

map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")

---------------------------------------------------------------------------
-- Insert mode window navigation
---------------------------------------------------------------------------

map("i", "<A-h>", "<C-\\><C-N><C-w>h")
map("i", "<A-j>", "<C-\\><C-N><C-w>j")
map("i", "<A-k>", "<C-\\><C-N><C-w>k")
map("i", "<A-l>", "<C-\\><C-N><C-w>l")

---------------------------------------------------------------------------
-- Terminal mode window navigation
---------------------------------------------------------------------------

map("t", "<A-h>", "<C-\\><C-N><C-w>h")
map("t", "<A-j>", "<C-\\><C-N><C-w>j")
map("t", "<A-k>", "<C-\\><C-N><C-w>k")
map("t", "<A-l>", "<C-\\><C-N><C-w>l")

---------------------------------------------------------------------------
-- Insert mode escape
---------------------------------------------------------------------------

map("i", "kj", "<Esc>")
map("i", "jk", "<Esc>ll")

---------------------------------------------------------------------------
-- Transparent toggle
---------------------------------------------------------------------------

map("n", "<leader>b", ":TransparentToggle<CR>")

---------------------------------------------------------------------------
-- Command mode shortcut
---------------------------------------------------------------------------

map("n", ";", ":")

---------------------------------------------------------------------------
-- LSP
---------------------------------------------------------------------------

local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local function lsp_attach(client, bufnr)
  local opts = { buffer = bufnr, silent = true }

  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "gD", vim.lsp.buf.declaration, opts)
  map("n", "gi", vim.lsp.buf.implementation, opts)
  map("n", "go", vim.lsp.buf.type_definition, opts)
  map("n", "gr", vim.lsp.buf.references, opts)
  map("n", "gs", vim.lsp.buf.signature_help, opts)

  map("n", "<F2>", vim.lsp.buf.rename, opts)

  map({ "n", "x" }, "<F3>", function()
    vim.lsp.buf.format({ async = true })
  end, opts)

  map("n", "<leader>o", vim.lsp.buf.code_action, opts)

  map("n", "<leader>e", function()
    vim.diagnostic.open_float(nil, {
      focus = true,
      border = "rounded",
    })
  end, {
    buffer = bufnr,
    desc = "Show diagnostic under cursor",
  })
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client then
      lsp_attach(client, args.buf)
    end
  end,
})

---------------------------------------------------------------------------
-- Mason
---------------------------------------------------------------------------

require("mason").setup()

---------------------------------------------------------------------------
-- Mason LSP config
---------------------------------------------------------------------------

local mason_lsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")

if mason_lsp_ok then
  mason_lspconfig.setup({
    ensure_installed = {},
  })
end

---------------------------------------------------------------------------
-- LSP server configuration
--
-- Add servers here as needed.
--
-- Example:
--
-- vim.lsp.config("lua_ls", {
--   capabilities = capabilities,
-- })
--
-- vim.lsp.enable("lua_ls")
---------------------------------------------------------------------------

---------------------------------------------------------------------------
-- nvim-cmp
---------------------------------------------------------------------------

local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
  }),

  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})

---------------------------------------------------------------------------
-- Treesitter
---------------------------------------------------------------------------

local treesitter_ok, treesitter = pcall(require, "nvim-treesitter")

if treesitter_ok then
  -- Keep Treesitter available without automatic parser installation.
  -- Parser installation can be handled separately.
end

---------------------------------------------------------------------------
-- Colorscheme
---------------------------------------------------------------------------

-- vim.cmd.colorscheme("retrobox")
-- vim.cmd.colorscheme("carbonfox")
-- vim.cmd("AirlineTheme base16_gruvbox_dark_pale")


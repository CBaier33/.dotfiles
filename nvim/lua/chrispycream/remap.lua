vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-f>", ":NERDTreeToggle<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


vim.keymap.set("n", "<leader>w", ":tab new<CR>:Ex<CR>")
vim.keymap.set("n", "<leader>n", ":tabn<CR>")
vim.keymap.set("n", "<leader>p", ":tabp<CR>")

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("i", "jk", "<Esc>ll")


vim.keymap.set("n", ";", ':')

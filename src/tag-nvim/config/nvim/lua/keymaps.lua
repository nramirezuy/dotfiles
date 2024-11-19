vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "}q", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "{q", "<cmd>cprevious<CR>zz")

require('nico')

require('rose-pine').setup({ variant = 'moon' })
vim.cmd('colorscheme rose-pine')

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.colorcolumn = '80'
vim.opt.signcolumn = 'no'

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.scrolloff = 999 -- scroll from the middle of the screen

vim.opt.virtualedit = "block"

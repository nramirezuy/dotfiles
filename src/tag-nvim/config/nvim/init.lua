require('nico')

require('rose-pine').setup({ variant = 'moon' })
vim.cmd('colorscheme rose-pine')
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.colorcolumn = '80'
vim.opt.signcolumn = 'no'

vim.opt.wrap = false
vim.opt.scrolloff = 999 -- scroll from the middle of the screen

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

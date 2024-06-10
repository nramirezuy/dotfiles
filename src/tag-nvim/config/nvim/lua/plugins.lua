-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { 
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({ variant = 'moon' })
            vim.cmd('colorscheme rose-pine')
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c",
                    "hcl",
                    "lua",
                    "make",
                    "proto",
                    "python",
                    "sql",
                    "toml",
                    "vim",
                    "vimdoc",
                    "query",
                },

                auto_install = true,

                highlight = {
                    enable = true,
                },
            })
        end,
    },
})

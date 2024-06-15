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
            require("rose-pine").setup({ variant = "moon" })
            vim.cmd("colorscheme rose-pine")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c",
                    "gitcommit",
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
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<leader>ss",
                        node_incremental = "<Leader>si",
                        scope_incremental = "<Leader>sc",
                        node_decremental = "<Leader>sd",
                    }
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        },
                        selection_modes = {
                            ["@parameter.outer"] = "v",
                            ["@function.outer"] = "V",
                            ["@class.outer"] = "<c-v>",
                        },
                        include_surrounding_whitespace = true,
                    },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            require("plugins.lspconfig")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
            vim.keymap.set("n", "<C-p>", builtin.git_files, {})
            vim.keymap.set(
                "n",
                "<leader>ps",
                function()
                    builtin.grep_string({ search = vim.fn.input("Grep > ") });
                end
            )
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-cmdline" },
        config = function()
              local cmp = require"cmp"
              cmp.setup({
                  window = {},
                  mapping = cmp.mapping.preset.insert({
                      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                      ["<C-f>"] = cmp.mapping.scroll_docs(4),
                      ["<C-Space>"] = cmp.mapping.complete(),
                      ["<C-e>"] = cmp.mapping.abort(),
                      ["<CR>"] = cmp.mapping.confirm({ select = true }),
                  }),
                  sources = cmp.config.sources({
                      { name = "nvim_lsp" },
                  }, {
                      { name = "buffer" },
                  })
              })
              cmp.setup.cmdline({ "/", "?" }, {
                  mapping = cmp.mapping.preset.cmdline(),
                  sources = {
                      { name = "buffer" }
                  }
              })
              cmp.setup.cmdline(":", {
                  mapping = cmp.mapping.preset.cmdline(),
                  sources = cmp.config.sources({
                      { name = "path" }
                  }, {
                      { name = "cmdline" }
                  }),
                  matching = { disallow_symbol_nonprefix_matching = false }
              })
        end,
    },
})

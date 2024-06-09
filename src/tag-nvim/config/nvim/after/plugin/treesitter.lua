require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'c',
        'hcl',
        'lua',
        'make',
        'proto',
        'python',
        'sql',
        'toml',
        'vim',
        'vimdoc',
    },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

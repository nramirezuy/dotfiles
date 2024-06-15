local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.pylsp.setup({
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                ruff = {
                    enabled = true,
                    formatEnabled = true,
                    lineLength = 79,
                },
                pylsp_mypy = {
                    enabled = true,
                    overrides = {"--python-executable", "python", true},
                }
            }
        }
    }
})

local lspconfig = require("lspconfig")
lspconfig.pylsp.setup({
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

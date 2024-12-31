local M = {}

function M.setup(defaults)
    local lspconfig = require("lspconfig")

    local config = defaults
    config.settings = {
        pylsp = {
            plugins = {
                ruff = {
                    enabled = true,
                    formatEnabled = true,
                    executable = "ruff",
                    format = { "I" },
                    lineLength = 79,
                },
                pylsp_mypy = {
                    enabled = true,
                    overrides = { "--python-executable", "python", true },
                }
            }
        }
    }

    lspconfig.pylsp.setup(config)
end

return M

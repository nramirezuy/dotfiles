local M = {}

function M.setup(defaults)
    local lspconfig = require("lspconfig")

    local config = defaults
    config.settings = {
        docker = {
            languageserver = {
                formatter = {
                    ignoreMultilineInstructions = true,
                }
            }
        }
    }

    lspconfig.dockerls.setup(config)
end

return M

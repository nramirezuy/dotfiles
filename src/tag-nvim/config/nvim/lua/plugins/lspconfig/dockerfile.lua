local M = {}

function M.setup(defaults)
    local lsp_name = 'dockerls'

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

    vim.lsp.config(lsp_name, config)
    vim.lsp.enable(lsp_name)
end

return M

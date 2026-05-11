local M = {}

function M.setup(defaults)
    local lsp_name = "pylsp"

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
                    unsafeFixes = true,
                },
                pylsp_mypy = {
                    enabled = true,
                    overrides = { "--python-executable", "python", true },
                }
            }
        }
    }

    vim.lsp.config(lsp_name, config)
    vim.lsp.enable(lsp_name)
end

return M

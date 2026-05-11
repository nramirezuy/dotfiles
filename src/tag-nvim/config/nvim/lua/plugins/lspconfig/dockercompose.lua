local M = {}

function M.setup(defaults)
    local lsp_name =  'docker_compose_language_service'

    local config = defaults

    vim.lsp.config(lsp_name, config)
    vim.lsp.enable(lsp_name)
end

return M

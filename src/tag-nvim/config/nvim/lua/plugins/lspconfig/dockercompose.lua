local M = {}

function M.setup(defaults)
    local lspconfig = require("lspconfig")

    local config = defaults

    lspconfig.docker_compose_language_service.setup(config)
end

return M

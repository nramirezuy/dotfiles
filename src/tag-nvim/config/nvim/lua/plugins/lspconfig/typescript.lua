local M = {}

function M.setup(defaults)
    local typescript_tools = require("typescript-tools")

    local config = defaults
    config.settings = {
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        expose_as_code_action = "all",
        tsserver_max_memory = "auto",
        tsserver_locale = "en",
        jsx_close_tag = {
            enable = true,
            filetypes = { "javascriptreact", "typescriptreact" },
        }
    }

    typescript_tools.setup(config)
end

return M

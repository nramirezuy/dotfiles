local M = {}

function M.setup(defaults)
    local lspconfig = require("lspconfig")

    local config = defaults
    config.cmd = {
        "jdtls",
        "--java-executable", "/usr/lib/jvm/java-24-openjdk/bin/java",
        "-configuration", vim.fn.expand("$HOME/.cache/jdtls/config"),
        "-data", vim.fn.expand("$HOME/.cache/jdtls/workspace"),
    }

    -- Add Java Agents
    local maven_repository = vim.fn.expand("$HOME/.m2/repository/")
    local java_agents = {
        lombok = vim.fn.glob(
            maven_repository .. "**/*lombok*.jar"
        ):match("^[^\n]+"),
    }

    for _, file in pairs(java_agents) do
        table.insert(config.cmd, "--jvm-arg=-javaagent:" .. file)
    end

    lspconfig.jdtls.setup(config)
end

return M

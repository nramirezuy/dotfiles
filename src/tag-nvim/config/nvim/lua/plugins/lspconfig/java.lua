local M = {}

function M.setup(defaults)
    local lsp_name = "jdtls"

    local config = defaults
    config.cmd = {
        "jdtls",
        "--java-executable", "/usr/lib/jvm/java-25-openjdk/bin/java",
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

    vim.lsp.config(lsp_name, config)
    vim.lsp.enable(lsp_name)
end

return M

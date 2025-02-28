local M = {}

function M.setup(defaults)
    local lspconfig = require("lspconfig")


    local config = defaults
    config.on_init = function(client)
        local path = client.workspace_folders[1].name
        if (
                vim.loop.fs_stat(path .. '/.luarc.json')
                or vim.loop.fs_stat(path .. '/.luarc.jsonc')
            ) then
            return
        end

        client.config.settings.Lua = vim.tbl_deep_extend(
            "force",
            client.config.settings.Lua,
            {
                runtime = {
                    version = 'LuaJIT'
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                        "${3rd}/luv/library",
                    }
                }
            }
        )
    end
    config.settings = { Lua = { format = { enable = true } } }
    lspconfig.lua_ls.setup(config)
end

return M

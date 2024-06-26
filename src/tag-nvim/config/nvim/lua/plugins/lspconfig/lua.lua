local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()


lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if (
            vim.loop.fs_stat(path..'/.luarc.json')
            or vim.loop.fs_stat(path..'/.luarc.jsonc')
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
    end,
    settings = {
        Lua = {}
    }
})

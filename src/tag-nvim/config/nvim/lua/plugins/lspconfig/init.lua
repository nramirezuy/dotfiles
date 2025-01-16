local dockerfile = require("plugins.lspconfig.dockerfile")
local lua = require("plugins.lspconfig.lua")
local python = require("plugins.lspconfig.python")


local M = {}


function M.on_attach(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd(
            "BufWritePre",
            {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            }
        )
    end

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<space>fo", vim.lsp.buf.format, bufopts)

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

function M.setup()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local defaults = { capabilities = capabilities, on_attach = M.on_attach }
    dockerfile.setup(defaults)

    local defaults = { capabilities = capabilities, on_attach = M.on_attach }
    lua.setup(defaults)

    local defaults = { capabilities = capabilities, on_attach = M.on_attach }
    python.setup(defaults)
end

return M

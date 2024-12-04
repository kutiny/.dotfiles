return {
    {
        'neovim/nvim-lspconfig',
        lazy = true,
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'b0o/schemastore.nvim' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            local lspconfig_defaults = require('lspconfig').util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- This is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                end,
            })

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'ts_ls',
                    'eslint',
                    'lua_ls',
                    'bashls',
                    'cssls',
                    'dockerls',
                    'docker_compose_language_service',
                    'jsonls',
                    'yamlls',
                    'marksman',
                    'emmet_language_server',
                },
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                    lua_ls = function()
                        require('lspconfig').lua_ls.setup({})
                    end,
                    jsonls = function()
                        require("lspconfig").jsonls.setup({
                            settings = {
                                json = {
                                    schemas = require("schemastore").json.schemas(),
                                    validate = { enable = true },
                                },
                            },
                        })
                    end,
                    yamlls = function()
                        require("lspconfig").yamlls.setup({
                            settings = {
                                yaml = {
                                    schemaStore = {
                                        -- You must disable built-in schemaStore support if you want to use
                                        -- this plugin and its advanced options like ignore.
                                        enable = false,
                                        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                                        url = "",
                                    },
                                    schemas = require("schemastore").yaml.schemas(),
                                },
                            },
                        })
                    end,
                }
            })
        end
    },
}

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
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "LspAttach", -- Or `LspAttach`
        priority = 1000,     -- needs to be loaded in first
        opts = {
            signs = {
                left = "",
                right = "",
                diag = "●",
                arrow = "    ",
                up_arrow = "    ",
                vertical = " │",
                vertical_end = " └",
            },
            hi = {
                error = "DiagnosticError",
                warn = "DiagnosticWarn",
                info = "DiagnosticInfo",
                hint = "DiagnosticHint",
                arrow = "NonText",
                background = "CursorLine", -- Can be a highlight or a hexadecimal color (#RRGGBB)
                mixing_color = "None", -- Can be None or a hexadecimal color (#RRGGBB). Used to blend the background color with the diagnostic background color with another color.
            },
            blend = {
                factor = 0.27,
            },
            options = {
                -- Show the source of the diagnostic.
                show_source = false,

                -- Throttle the update of the diagnostic when moving cursor, in milliseconds.
                -- You can increase it if you have performance issues.
                -- Or set it to 0 to have better visuals.
                throttle = 20,

                -- The minimum length of the message, otherwise it will be on a new line.
                softwrap = 30,

                -- If multiple diagnostics are under the cursor, display all of them.
                multiple_diag_under_cursor = false,

                -- Enable diagnostic message on all lines.
                multilines = true,

                -- Show all diagnostics on the cursor line.
                show_all_diags_on_cursorline = true,

                -- Enable diagnostics on Insert mode. You should also se the `throttle` option to 0, as some artefacts may appear.
                enable_on_insert = false,

                overflow = {
                    -- Manage the overflow of the message.
                    --    - wrap: when the message is too long, it is then displayed on multiple lines.
                    --    - none: the message will not be truncated.
                    --    - oneline: message will be displayed entirely on one line.
                    mode = "wrap",
                },

                -- Format the diagnostic message.
                -- Example:
                -- format = function(diagnostic)
                --     return diagnostic.message .. " [" .. diagnostic.source .. "]"
                -- end,
                format = nil,

                --- Enable it if you want to always have message with `after` characters length.
                break_line = {
                    enabled = false,
                    after = 30,
                },

                virt_texts = {
                    priority = 2048,
                },

                -- Filter by severity.
                severity = {
                    vim.diagnostic.severity.ERROR,
                    vim.diagnostic.severity.WARN,
                    vim.diagnostic.severity.INFO,
                    vim.diagnostic.severity.HINT,
                },

                -- Overwrite events to attach to a buffer. You should not change it, but if the plugin
                -- does not works in your configuration, you may try to tweak it.
                overwrite_events = nil,
            },
        },
    }
}

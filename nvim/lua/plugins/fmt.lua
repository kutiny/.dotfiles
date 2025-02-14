return {
    'dense-analysis/ale',
    enabled = true,
    config = function()
        local g = vim.g

        g.ale_set_loclist = 0
        g.ale_set_quickfix = 1
        g.ale_disable_lsp = 1
        g.ale_virtualtext_cursor = 'disabled'
        g.ale_disable_linter = 1

        g.ale_ruby_rubocop_auto_correct_all = 1

        g.ale_linters = {
            lua = { 'lua_language_server' },
        }

        g.ale_fixers = {
            lua = { 'stylua' },
            javascript = { 'prettier' },
            typescript = { 'prettier' },
            css = { 'prettier' },
            scss = { 'prettier' },
            less = { 'prettier' },
            html = { 'prettier' },
            sh = { 'shfmt' },
        }

        local group = vim.api.nvim_create_augroup('ktn_fmt', { clear = true })

        local isEnabled = function()
            local enabled = table.getn(vim.api.nvim_get_autocmds({ group = group })) > 0
            return enabled
        end

        vim.keymap.set("n", "<leader>ff", function()
            vim.cmd([[ALEFix]])
        end)

        vim.api.nvim_create_user_command('FormatOnSave', function()
            local enabled = isEnabled()
            if enabled then
                print('FormatOnSave is enabled')
            else
                print('FormatOnSave is disabled')
            end
        end, {})

        vim.api.nvim_create_user_command('FormatOnSaveOn', function()
            if isEnabled() then
                print('FormatOnSave is already enabled')
                return
            end
            vim.g.ale_fix_on_save = true
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = group,
                pattern = '*',
                callback = function()
                    vim.cmd([[ALEFix]])
                    -- vim.lsp.buf.format { filter = function(client) return client.name ~= 'tsserver' end }
                end
            })
        end, {})

        vim.api.nvim_create_user_command('FormatOnSaveOff', function()
            if not isEnabled() then
                print('FormatOnSave is already disabled')
                return
            end
            vim.g.ale_fix_on_save = false
            vim.api.nvim_clear_autocmds({
                group = group,
            })
        end, {})
    end,
}

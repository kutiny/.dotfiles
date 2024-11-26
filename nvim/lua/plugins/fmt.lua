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

        vim.api.nvim_create_autocmd('BufWritePre', {
            group = group,
            pattern = '*',
            callback = function()
                vim.cmd([[ALEFix]])
                -- vim.lsp.buf.format { filter = function(client) return client.name ~= 'tsserver' end }
            end
        })

        vim.keymap.set("n", "<leader>ff", function()
            vim.cmd([[ALEFix]])
        end)

    end,
}

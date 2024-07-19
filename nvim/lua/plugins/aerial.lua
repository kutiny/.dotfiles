return {
    'stevearc/aerial.nvim',
    cmd = { 'AerialToggle' },
    lazy = true,
    opts = {
        close_on_select = true,
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        -- on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        -- vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        -- vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        -- end
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    keys = {
        { "<leader>o", "<cmd>AerialToggle left<CR>", desc = "Outline toggle" },
    },
}

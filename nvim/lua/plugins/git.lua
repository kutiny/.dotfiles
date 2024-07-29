return {
    {
        'f-person/git-blame.nvim',
        cmd = { 'GitBlameToggle' },
        opts = {
            enabled = false,
            delay = 100,
        },
        keys = {
            { "<leader>bb", "<cmd>GitBlameToggle<CR>", desc = "Blame toggle" },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {},
        ft = { '!dashboard' },
    },
}

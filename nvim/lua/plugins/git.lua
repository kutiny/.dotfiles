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
        event = { 'BufReadPre', 'BufNewFile' },
        ft = { '!dashboard' },
        keys = {
            { "<leader>gh", "<cmd>Gitsigns preview_hunk<CR>", desc = "Git preview hunk" },
            { "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>", desc = "Git prev hunk" },
            { "<leader>gn", "<cmd>Gitsigns next_hunk<CR>", desc = "Git next hunk" },
        },
    },
}

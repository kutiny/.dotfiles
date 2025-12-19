return {
    {
        'f-person/git-blame.nvim',
        cmd = { 'GitBlameToggle' },
        opts = {
            delay = 100,
            message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
            date_format = "%d %b %Y %H:%M:%S (%r)", -- template for the date, check Date format section for more options
            virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
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
            { "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>",    desc = "Git prev hunk" },
            { "<leader>gn", "<cmd>Gitsigns next_hunk<CR>",    desc = "Git next hunk" },
            { "<leader>bl", "<cmd>Gitsigns blame_line<CR>",   desc = "Git blame line" },
        },
    },
}

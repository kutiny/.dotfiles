return {
    {
        'christoomey/vim-tmux-navigator',
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        'kutiny/tmux.nvim',
        dev = true,
        cmd = { 'ListSessions', },
        enabled = false,
        keys = {
            { '<leader>ts', '<cmd>ListSessions<CR>' },
        },
        opts = {},
        init = function()
            -- vim.keymap.set("n", "<leader>ts", "<cmd>TmuxListSessions<CR>", {})
        end
    }
}

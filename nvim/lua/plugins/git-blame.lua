return {
    'f-person/git-blame.nvim',
    opts = {
        enabled = false,
        delay = 100,
    },
    keys = {
        { "<leader>bb", "<cmd>GitBlameToggle<CR>", desc = "Blame toggle" },
    },
}

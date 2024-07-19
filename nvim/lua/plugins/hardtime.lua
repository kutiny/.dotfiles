return {
    "m4xshen/hardtime.nvim",
    enabled = false,
    cmd = { 'Hardtime' },
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
        max_count = 5,
    },
    keys = {
        { "<leader>h", "<cmd>Hardtime toggle<CR>" },
    },
}

return {
    'kutiny/buff.nvim',
    dev = false,
    cmd = { 'BuffListToggle' },
    opts = {
        ignore_patterns = {
            "oil:.*",
        },
        window = {
            -- fixed_width = 10,
            auto_width = true,
            -- percentage_width = 10,
        },
    },
    keys = {
        { '<leader>c', "<cmd>BuffListToggle<CR>", { silent = true } }
    },
}

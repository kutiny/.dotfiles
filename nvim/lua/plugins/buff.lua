return {
    'kutiny/buff.nvim',
    dev = false,
    cmd = { 'BuffListToggle' },
    opts = {
        ignore_patterns = {
            "oil:.*",
        }
    },
    keys = {
        { '<leader>c', "<cmd>BuffListToggle<CR>", { silent = true } }
    },
}

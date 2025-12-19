return {
    {
        'nvim-tree/nvim-tree.lua',
        lazy = true,
        event = {'VeryLazy'},
        -- event = { 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeFindFile', 'NvimTreeCollapse' },
        opts = {
            update_focused_file = {
                enable = true
            }
        },
        keys = {
            { "<c-w>t", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" }
        }
    }
}

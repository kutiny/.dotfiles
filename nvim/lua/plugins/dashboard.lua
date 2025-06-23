return {
    'nvimdev/dashboard-nvim',
    lazy = false,
    enabled = false,
    config = function()
        -- vim.cmd('highlight KittyConf guifg=#2f7366')
        require('dashboard').setup {
            theme = 'hyper',
            config = {
                header = {
                    '      ♥️',
                    '',
                    '',
                    '',
                    '',
                },
                project = {
                    enable = false,
                },
                mru = {
                    limit = 5,
                    label = ' Recent files:',
                },
                disable_move = false, -- boolean default is false disable move key
                footer = { },
                shortcut = {
                    { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                    {
                        icon = ' ',
                        icon_hl = '@variable',
                        desc = 'Files',
                        group = 'Label',
                        action = 'Oil',
                        key = 'f',
                    },
                    {
                        desc = ' dotfiles',
                        group = 'Number',
                        action = 'e ~/.dotfiles',
                        key = 'd',
                    },
                    {
                        desc = ' kittyconf',
                        group = 'Function',
                        action = 'e ~/.dotfiles/pub/kitty/kitty.conf',
                        key = 'K',
                    },
                },
            },
        }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}

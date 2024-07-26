return {
    {
        'mvllow/modes.nvim',
        event = 'VeryLazy',
        tag = 'v0.2.1',
        opts = {
            colors = {
                bg = "", -- Optional bg param, defaults to Normal hl group
                copy = "#f5c359",
                delete = "#c75c6a",
                insert = "#78ccc5",
                visual = "#9745be",
            },

            -- Set opacity for cursorline and number background
            line_opacity = 0.25,

            -- Enable cursor highlights
            set_cursor = true,

            -- Enable cursorline initially, and disable cursorline for inactive windows
            -- or ignored filetypes
            set_cursorline = true,

            -- Enable line number highlights to match cursorline
            set_number = true,

            -- Disable modes highlights in specified filetypes
            -- Please PR commonly ignored filetypes
            ignore_filetypes = { 'NvimTree', 'TelescopePrompt' }
        },
    },
    {
        'mawkler/modicator.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {},
    },
    {
        'gen740/SmoothCursor.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            fancy = {
                enable = true,
                head = {
                    cursor = '▷',
                }
            }
        },
    },
}

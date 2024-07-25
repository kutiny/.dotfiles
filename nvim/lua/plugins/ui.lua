return {
    {
        'mvllow/modes.nvim',
        event = 'VeryLazy',
        tag = 'v0.2.1',
        opts = {},
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

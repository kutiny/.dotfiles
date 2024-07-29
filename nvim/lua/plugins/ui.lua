return {
    {
        'mvllow/modes.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
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
    {
        "folke/noice.nvim",
        event = { 'BufRead', 'BufNewFile' },
        lazy = true,
        opts = {
            {
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            { "rcarriga/nvim-notify", opts = { background_colour = "#000000" } },
        }
    }
}

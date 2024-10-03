return {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        chunk = {
            enable = true,
            style = { '#806d9c' },
            notify = false,
            priority = 0,
            exclude_filetypes = {
                aerial = true,
                dashboard = true,
            },
            duration = 150,
            delay = 250,
            chars = {
                horizontal_line = "─",
                vertical_line = "│",
                left_top = "╭",
                left_bottom = "╰",
                right_arrow = "─",
            },
        },
        indent = {
            enable = false,
            style = {
                "#AD343E",
                "#7E262D",
            },
            notify = false,
            priority = 15,
            exclude_filetypes = {
                aerial = true,
                dashboard = true,
            },
        },
        line_num = {
            enable = true,
            style = "#806d9c",
            priority = 10,
            use_treesitter = false,
        }

    }
}

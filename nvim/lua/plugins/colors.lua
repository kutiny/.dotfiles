local transparency = true

return {
    {
        'kutiny/colors.nvim',
        branch = 'main',
        dev = false,
        event = { 'VeryLazy' },
        opts = {
            enable_transparent_bg = transparency,
            fallback_theme_name = 'catppuccin',
            hide_builtins = true,
            ignore_themes = {
                'catppuccin-latte',
            },
            border = 'rounded',
            icon = nil,
            title = ' Themes ',
            title_position = 'center',
            height = 10,
            width = 60,
            persist = true,
            callback_fn = function()
                require('lualine').setup({});
                require('nvim-web-devicons').refresh()
            end
        },
        init = function()
            vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>ShowThemes<CR>", { silent = true })
        end,
    },
    {
        "sainnhe/gruvbox-material",
        lazy = true,
        name = 'gruvbox',
        priority = 1000,
        event = 'UIEnter',
        opts = {
            transparent = transparency,
        },
        init = function()
            vim.g.gruvbox_material_background = 'hard'
            vim.g.gruvbox_material_foreground = 'original'
            vim.g.gruvbox_material_transparent_background = transparency and 2 or 0
        end
    },
    {
        "bluz71/vim-nightfly-colors",
        lazy = true,
        name = 'nightfly',
        priority = 1000,
        event = 'UIEnter',
        enabled = true,
        init = function()
            vim.g.nightflyTransparent = transparency
            vim.g.nightflyUnderlineMatchParen = true
            vim.g.nightflyWinSeparator = 0
        end,
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = true,
        event = 'UIEnter',
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                flavour = "auto", -- latte, frappe, macchiato, mocha
                background = {    -- :h background
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = transparency, -- disables setting the background color.
                show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
                term_colors = false,           -- sets terminal colors (e.g. `g:terminal_color_0`)
                dim_inactive = {
                    enabled = false,           -- dims the background color of inactive window
                    shade = "dark",
                    percentage = 0.15,         -- percentage of the shade to apply to the inactive window
                },
                no_italic = false,             -- Force no italic
                no_bold = false,               -- Force no bold
                no_underline = false,          -- Force no underline
                styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
                    comments = { "italic" },   -- Change the style of comments
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                    -- miscs = {}, -- Uncomment to turn off hard-coded styles
                },
                color_overrides = {},
                custom_highlights = {},
                default_integrations = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                },
            })
        end
    },
    {
        'tanvirtin/monokai.nvim',
        priority = 1000,
        lazy = true,
        event = 'UIEnter',
    },
    {
        'yorumicolors/yorumi.nvim',
        priority = 1000,
        lazy = true,
        event = 'UIEnter',
        name = 'Yorumi',
    },
}

return {
    {
        'kutiny/colors.nvim',
        branch = 'main',
        dev = false,
        event = { 'VeryLazy' },
        opts = {
            enable_transparent_bg = true,
            fallback_theme_name = 'catppuccin',
            hide_builtins = true,
            ignore_themes = {
                'catppuccin-latte',
                'rose-pine-dawn',
                'rose-pine-moon',
                'rose-pine-main',
                'dawnfox',
                'dayfox',
                'tokyonight-day',
                'witch-light',
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
            transparent = true,
        },
        init = function()
            vim.g.gruvbox_material_background = 'hard'
            vim.g.gruvbox_material_foreground = 'original'
            vim.g.gruvbox_material_transparent_background = 2
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
            vim.g.nightflyTransparent = true
            vim.g.nightflyUnderlineMatchParen = true
            vim.g.nightflyWinSeparator = 0
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        name = 'tokyonight',
        priority = 1000,
        event = 'UIEnter',
        enabled = true,
        opts = {
            transparent = true,
        },
    },
    {
        'sainnhe/sonokai',
        name = 'sonokai',
        lazy = true,
        event = 'UIEnter',
        enabled = true,
        priority = 1000,
        config = function()
            vim.g.sonokai_transparent_background = true
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
                transparent_background = true, -- disables setting the background color.
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
        'comfysage/evergarden',
        priority = 1000,
        lazy = true,
        enabled = true,
        event = 'UIEnter',
        opts = {
            transparent_background = true,
            contrast_dark = 'hard', -- 'hard'|'medium'|'soft'
            overrides = {},         -- add custom overrides
        },
        name = 'evergarden',
    },
    {
        'rose-pine/neovim',
        priority = 1000,
        enabled = true,
        lazy = true,
        event = 'UIEnter',
        config = function()
            require("rose-pine").setup({
                variant = "auto",      -- auto, main, moon, or dawn
                dark_variant = "main", -- main, moon, or dawn
                dim_inactive_windows = false,
                extend_background_behind_borders = true,

                enable = {
                    terminal = true,
                    legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
                    migrations = true,        -- Handle deprecated options automatically
                },

                styles = {
                    bold = true,
                    italic = true,
                    transparency = true,
                },

                groups = {
                    border = "muted",
                    link = "iris",
                    panel = "surface",

                    error = "love",
                    hint = "iris",
                    info = "foam",
                    note = "pine",
                    todo = "rose",
                    warn = "gold",

                    git_add = "foam",
                    git_change = "rose",
                    git_delete = "love",
                    git_dirty = "rose",
                    git_ignore = "muted",
                    git_merge = "iris",
                    git_rename = "pine",
                    git_stage = "iris",
                    git_text = "rose",
                    git_untracked = "subtle",

                    h1 = "iris",
                    h2 = "foam",
                    h3 = "rose",
                    h4 = "gold",
                    h5 = "pine",
                    h6 = "foam",
                },

                highlight_groups = {
                    -- Comment = { fg = "foam" },
                    -- VertSplit = { fg = "muted", bg = "muted" },
                },

                before_highlight = function(group, highlight, palette)
                    -- Disable all undercurls
                    -- if highlight.undercurl then
                    --     highlight.undercurl = false
                    -- end
                    --
                    -- Change palette colour
                    -- if highlight.fg == palette.pine then
                    --     highlight.fg = palette.foam
                    -- end
                end,
            })
        end,
        name = 'rose-pine',
    },
    {
        "savq/melange-nvim",
        priority = 1000,
        lazy = true,
        event = 'UIEnter',
    },
}

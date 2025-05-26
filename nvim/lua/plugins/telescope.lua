return {
    'nvim-telescope/telescope.nvim',
    version = '0.1.8',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            version = "^1.0.0",
        },
    },
    cmd = { 'Telescope' },
    keys = {
        { '<leader>ps', function()
            local builtin = require('telescope.builtin')
            local themes = require('telescope.themes')
            vim.ui.input({ prompt = 'Grep  ' }, function(input)
                if input == nil then
                    return
                end
                builtin.grep_string(themes.get_dropdown({ search = input }))
            end)
            -- builtin.grep_string(themes.get_dropdown({
            --     search = vim.fn.input("Grep > "),
            -- }));
        end },
        { '<leader>pf', function()
            local builtin = require('telescope.builtin')
            local themes = require('telescope.themes')
            builtin.find_files(themes.get_dropdown({}))
        end },
        { '<leader>fs', function()
            local builtin = require('telescope.builtin')
            builtin.live_grep()
        end },
        { '<C-p>', function()
            local builtin = require('telescope.builtin')
            builtin.git_files()
        end },
    },
    config = function()
        local lga_actions = require("telescope-live-grep-args.actions")
        require('telescope').setup({
            defaults = {
                -- NOTE: this is the only thing that works for hidden files search in rp
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--hidden",
                    "--smart-case",
                },
                -- mappings = {
                --     n = {
                --         ["x"] = require("telescope.actions").delete_buffer,
                --         ["Esc"] = "close",
                --         ["q"] = require("telescope.actions").add_selected_to_qflist
                --         + require("telescope.actions").open_qflist,
                --         ["Q"] = require("telescope.actions").send_selected_to_qflist
                --         + require("telescope.actions").open_qflist,
                --     },
                --     i = {
                --         ["<C-Down>"] = require("telescope.actions").cycle_history_next,
                --         ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
                --     },
                -- },
                -- Default configuration for telescope goes here:
                -- config_key = value,
                -- ..
            },
            pickers = {
                colorscheme = {
                    enable_preview = true,
                },
                find_files = {
                    hidden = true,
                },
                live_grep = {
                    hidden = true, -- Look note on top
                },
                buffers = {
                    initial_mode = "normal",
                    hidden = true,
                },
                git_commits = {
                    initial_mode = "normal",
                },
                git_bcommits = {
                    initial_mode = "normal",
                },
                git_status = {
                    initial_mode = "normal",
                },
                lsp_references = {
                    initial_mode = "normal",
                },
                resume = {
                    initial_mode = "normal",
                },
            },
            extensions = {
                live_grep_args = {
                    auto_quoting = true, -- enable/disable auto-quoting
                    -- define mappings, e.g.
                    mappings = { -- extend mappings
                        i = {
                            ["<C-k>"] = lga_actions.quote_prompt(),
                            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            -- freeze the current list and start a fuzzy search in the frozen list
                            ["<C-space>"] = lga_actions.to_fuzzy_refine,
                        },
                    },
                    -- ... also accepts theme settings, for example:
                    -- theme = "dropdown", -- use dropdown theme
                    -- theme = { }, -- use own theme spec
                    -- layout_config = { mirror=true }, -- mirror preview pane
                }
            },
        })
        require("telescope").load_extension("git_worktree")
        require("telescope").load_extension("live_grep_args")
    end
}

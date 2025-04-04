return {
    {
        'microsoft/vscode-js-debug',
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            --  UI
            'rcarriga/nvim-dap-ui',
            -- Required dependency for nvim-dap-ui
            'nvim-neotest/nvim-nio',
            -- Installs the debug adapters for you
            'williamboman/mason.nvim',
            'jay-babu/mason-nvim-dap.nvim',
            -- Add your own debuggers here
            -- 'leoluz/nvim-dap-go',
            'mxsdev/nvim-dap-vscode-js'
        },
        keys = {
            {
                '<F5>',
                function()
                    require('dap').continue()
                end,
                desc = 'Debug: Start/Continue',
            },
            {
                '<F1>',
                function()
                    require('dap').step_into()
                end,
                desc = 'Debug: Step Into',
            },
            {
                '<F2>',
                function()
                    require('dap').step_over()
                end,
                desc = 'Debug: Step Over',
            },
            {
                '<F3>',
                function()
                    require('dap').step_out()
                end,
                desc = 'Debug: Step Out',
            },
            {
                '<leader>b',
                function()
                    require('dap').toggle_breakpoint()
                end,
                desc = 'Debug: Toggle Breakpoint',
            },
            {
                '<leader>B',
                function()
                    require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
                end,
                desc = 'Debug: Set Breakpoint',
            },
            -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
            {
                '<F7>',
                function()
                    require('dapui').toggle()
                end,
                desc = 'Debug: See last session result.',
            },
        },
        config = function()
            local dap = require 'dap'
            local dapui = require 'dapui'

            require('mason-nvim-dap').setup {
                -- Makes a best effort to setup the various debuggers with
                -- reasonable debug configurations
                automatic_installation = true,

                -- You can provide additional configuration to the handlers,
                -- see mason-nvim-dap README for more information
                handlers = {},

                -- You'll need to check that you have the required things installed
                -- online, please don't ask me how to install them :)
                ensure_installed = {
                    -- Update this to ensure that you have the debuggers for the langs you want
                    -- 'delve',
                },
            }

            -- Dap UI setup
            -- For more information, see |:help nvim-dap-ui|
            dapui.setup {
                -- Set icons to characters that are more likely to work in every terminal.
                --    Feel free to remove or use ones that you like more! :)
                --    Don't feel like these are good choices.
                icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
                controls = {
                    icons = {
                        pause = '⏸',
                        play = '▶',
                        step_into = '⏎',
                        step_over = '⏭',
                        step_out = '⏮',
                        step_back = 'b',
                        run_last = '▶▶',
                        terminate = '⏹',
                        disconnect = '⏏',
                    },
                },
            }

            -- Change breakpoint icons
            -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
            -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
            -- local breakpoint_icons = vim.g.have_nerd_font
            --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
            --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
            -- for type, icon in pairs(breakpoint_icons) do
            --   local tp = 'Dap' .. type
            --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
            --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
            -- end

            dap.listeners.after.event_initialized['dapui_config'] = dapui.open
            dap.listeners.before.event_terminated['dapui_config'] = dapui.close
            dap.listeners.before.event_exited['dapui_config'] = dapui.close

            -- Install golang specific config
            -- require('dap-go').setup {
            --   delve = {
            --     -- On Windows delve must be run attached or it crashes.
            --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
            --     detached = vim.fn.has 'win32' == 0,
            --   },
            -- }

            -- Setup node-debug2-adapter
            require('dap').adapters.node2 = {
                type = "executable",
                command = "node",
                args = {
                    require("mason-registry").get_package("node-debug2-adapter"):get_install_path() ..
                    "/out/src/nodeDebug.js",
                },
            }

            -- Setup firefox-debug-adapter
            require('dap').adapters.firefox = {
                type = "executable",
                command = "node",
                args = {
                    require("mason-registry").get_package("firefox-debug-adapter"):get_install_path() ..
                    "/dist/adapter.bundle.js",
                },
            }

            -- Configuration of the adapters for the respective language

            for _, language in pairs({ "javascript", "typescript" }) do
                require('dap').configurations[language] = {
                    {
                        name = "Launch Node against current file",
                        type = "node2",
                        request = "launch",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                        sourceMaps = true,
                        protocol = "inspector",
                        console = "integratedTerminal",
                    },
                    {
                        name = "Launch Lists Debug",
                        type = "node2",
                        request = "launch",
                        cwd = "${workspaceFolder}/apps/lists",
                        runtimeExecutable = "npm",
                        runtimeArgs = {
                            "run",
                            "nx-debug"
                        },
                        sourceMaps = true,
                        console = "integratedTerminal",
                    },
                    {
                        name = "Launch Node against pick process",
                        type = "node2",
                        request = "attach",
                        processId = require("dap.utils").pick_process,
                        console = "integratedTerminal",
                    },
                    {
                        name = "Launch Firefox against localhost",
                        request = "launch",
                        type = "firefox",
                        reAttach = true,
                        url = "http://localhost:3000",
                        webRoot = "${workspaceFolder}",
                        console = "integratedTerminal",
                    },
                }
            end

            for _, language in pairs({ "javascriptreact", "typescriptreact" }) do
                require('dap').configurations[language] = {
                    {
                        name = "Launch Firefox against localhost",
                        request = "launch",
                        type = "firefox",
                        reAttach = true,
                        url = "http://localhost:3000",
                        webRoot = "${workspaceFolder}",
                        console = "integratedTerminal",
                    },
                }
            end
        end,
    }
}

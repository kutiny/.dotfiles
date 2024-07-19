return {
    'kutiny/gcompile.nvim',
    lazy = true,
    opts = {
        split = 'horizontal',
    },
    keys = {
        { "<leader>rr", "<cmd>GCompileAndRun<CR>",     desc = "Compile and run" },
        { "<leader>re", "<cmd>GCompileRunAndExit<CR>", desc = "Compile, run and exit" },
    },
    ft = { "cpp" },
}

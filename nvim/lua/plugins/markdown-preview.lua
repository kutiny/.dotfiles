return {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
        -- Markdown preview
        vim.keymap.set("n", "<leader>p", ":MarkdownPreviewToggle\n", { silent = true })
    end,
    ft = { "markdown" },
}

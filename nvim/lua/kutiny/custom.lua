-- highlight selection on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
    pattern = "*",
    desc = "Highlight on yank",
    callback = function()
        vim.highlight.on_yank({ visual = true, timeout = 200 })
    end,
})

vim.api.nvim_create_user_command("OpenFolder", function()
    local path = vim.fn.expand("%:p:h")
    if not vim.fn.isdirectory(path) == 1 then
        path = path:gsub("Oil://", "")
    end
    vim.cmd("silent !open " .. path)
end, { desc = "Open the folder of the current file" })

vim.keymap.set("n", "<C-w><", "<CMD>vertical resize -15<CR>")
vim.keymap.set("n", "<C-w>>", "<CMD>vertical resize +15<CR>")
vim.keymap.set("n", "<C-w>+", "<CMD>resize +5<CR>")
vim.keymap.set("n", "<C-w>-", "<CMD>resize -5<CR>")


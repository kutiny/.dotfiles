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

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'single'
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end


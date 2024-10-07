return {
    'kutiny/git-worktree.nvim',
    dev = false,
    config = function()
        local worktree = require('git-worktree');
        worktree.on_tree_change(function(op, metadata)
            if op == worktree.Operations.Switch then
                require('oil').open(metadata.path)
            end
        end)
    end,
    keys = {
        { '<leader>wl', ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", { silent = true } },
        -- { '<leader>ws', ':lua require("git-worktree").create()<CR>' },
        -- { '<leader>wc', ':lua require("git-worktree").create(true)<CR>' },
        -- { '<leader>wd', ':lua require("git-worktree").delete()<CR>' },
        -- { '<leader>ww', ':lua require("git-worktree").switch()<CR>' },
    }
}

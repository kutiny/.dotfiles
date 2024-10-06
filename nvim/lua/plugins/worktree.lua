return {
    'ThePrimeagen/git-worktree.nvim',
    dev = true,
    config = function()
        local worktree = require('git-worktree');
        worktree.on_tree_change(function(op, metadata)
            if op == worktree.Operations.Switch then
                print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
                require('oil').open(metadata.path)
            end
        end)
    end,
}

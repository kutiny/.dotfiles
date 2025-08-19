-- set leader key
vim.g.mapleader = " "
vim.o.background = "dark"

vim.o.guicursor = ""

vim.o.nu = true
vim.o.rnu = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.smartindent = true

vim.o.wrap = true

vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.termguicolors = true

vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.o.updatetime = 50

vim.o.colorcolumn = "80"
vim.o.cursorcolumn = true
vim.o.cursorline = true
vim.o.culopt = "line,number"

-- vim.cmd[[highlight CursorColumn guibg=#c83e4d]]
-- vim.cmd [[highlight CursorLine guibg=#32373B]]
-- vim.cmd [[highlight ColorColumn guibg=#F4B860]]
-- vim.cmd [[highlight ColorColumn guibg=#5B5F97]]

vim.o.splitright = true
vim.o.splitbelow = true

vim.showmode = false

-- ### folds block start ###

CustomFoldText = function()
    local foldStartLine = table.concat(vim.fn.getbufline(vim.api.nvim_get_current_buf(), vim.v.foldstart));
	local border = " ";
	local padding = 0;
	local gap = foldStartLine:match('Gap:%s*"(%d+)"') ~= nil and tonumber(foldStartLine:match('Gap:%s*"(%d+)"')) or 3;
    local icon = "  "
    local lines = " " .. tostring((vim.v.foldend - vim.v.foldstart) + 1) .. " Lines ";
	local totalVirtualColumns = vim.api.nvim_win_get_width(0) - vim.fn.getwininfo(vim.fn.win_getid())[1].textoff;
	local fillCharLen = math.max(totalVirtualColumns - vim.fn.strchars(foldStartLine .. string.rep(border, padding) .. icon .. string.rep(border, gap * 2) .. lines .. border), 0);

	local _out = string.rep("-", padding) .. icon .. string.rep(" ", gap) .. foldStartLine .. string.rep(" ", gap) ..  lines .. string.rep(border, fillCharLen) .. border;

	return _out;
end


vim.o.foldtext = "v:lua.CustomFoldText()"

vim.o.foldmethod = "expr"
vim.o.foldenable = true
vim.o.foldlevelstart = 99
vim.o.foldlevel = 99
vim.o.foldcolumn = "0"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.cmdheight = 1

-- ### folds block end ###

-- vim.diagnostic.config({ virtual_text = false })

vim.cmd [[
  highlight NormalFloat guibg=#1e1e2e guifg=#cdd6f4
  highlight FloatBorder guibg=#1e1e2e guifg=#585b70
]]


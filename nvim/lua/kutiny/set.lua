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

-- folds
vim.o.foldmethod = "expr"
vim.o.foldenable = true
vim.o.foldlevelstart = 99
vim.o.foldlevel = 99
vim.o.foldcolumn = "0"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.cmdheight = 1

-- vim.diagnostic.config({ virtual_text = false })

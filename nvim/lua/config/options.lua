-- /options.lua --

vim.g.mapleader = " " -- leader
vim.g.maplocalleader = " "

vim.opt.number = true -- line numbers
vim.opt.relativenumber = true -- relative line numbers
vim.opt.mouse = "a" -- enable mouse mode
vim.opt.showmode = false

-- sync clipboard between os & nvim
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.breakindent = true -- break indent
vim.opt.undofile = true -- save undo history

vim.opt.ignorecase = true -- case-insenstive search
vim.opt.smartcase = true -- case sensitive search with \C<LETTER>

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250 -- decrease updatetime
vim.opt.timeoutlen = 300 -- decreases mapped sequence wait time

vim.opt.splitright = true -- new split right
vim.opt.splitbelow = true -- new split bottom

vim.opt.inccommand = "split" -- preview substitutions live
vim.opt.cursorline = true -- show line cursor is in
vim.opt.scrolloff = 10 -- min number of lines above & below cursor

-- fix indentation errors
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 3
vim.opt.softtabstop = 3
vim.opt.smartindent = true
vim.opt.autoindent = true

-- hide status line
vim.opt.laststatus = 0

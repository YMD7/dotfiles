--[[
=======================
General Settings
=======================
]]
-- disable unnecessary settings
-- // default vim filer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- encoding
vim.env.LANG = 'en_US.UTF-8'
vim.o.encoding = 'utf-8'

-- visual
vim.o.title = true
vim.o.number = true
vim.o.mouse = ''
vim.opt.termguicolors = true

-- buffer
-- // Control + j/k to switch buffer
vim.api.nvim_set_keymap("n", "<C-j>", ":bprev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":bnext<CR>", { noremap = true, silent = true })

-- edit
vim.o.tabstop = 2 -- number of visual spaces per TAB
vim.o.expandtab = true -- use spaces instead of tabs
vim.o.shiftwidth = 2 -- number of spaces to use for autoindent
vim.o.showmatch = true -- highlight matching [{()}]
vim.opt.clipboard:append{"unnamedplus"} -- enable sharing OS clipboard
vim.g.vim_json_syntax_conceal = 0 -- JSON のダブルクォーテーションの非表示化を無効にする

-- search
vim.o.hlsearch = false -- don't highlight matches
vim.o.ignorecase = true -- ignore case letters when searching
vim.o.smartcase = true -- ignore lowercase for the whole pattern
vim.o.wrapscan = true -- search wraps around the end of the file



--[[
=======================
Plugin Manager
=======================
]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")


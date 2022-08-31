require "plugins"

vim.cmd "filetype plugin indent on"

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.background = "dark"
vim.o.number = true
vim.o.clipboard = "unnamedplus"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 0
vim.o.expandtab = true
vim.o.shell = "/bin/zsh"

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
-- scrolling with mouse is nice
vim.o.mouse = "a"

vim.wo.wrap = false
vim.wo.cursorline = true
vim.wo.cursorcolumn = false
-- vim.wo.colorcolumn = "120"

vim.cmd "autocmd BufWritePre * StripWhitespace"

-- check for changes on disk on focus
vim.cmd "autocmd BufEnter,FocusGained * checktime"
vim.cmd "autocmd FocusGained * echo 'FocusGained'"

-- replace unimpaired bindings
vim.api.nvim_set_keymap("n", "[j", "<C-O>", {noremap = true})
vim.api.nvim_set_keymap("n", "]j", "<C-I>", {noremap = true})
vim.api.nvim_set_keymap("n", "[q", ":cp<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "]q", ":cn<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "[l", ":lp<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "]l", ":lne<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "[<space>", "O<Esc>j", {noremap = true})
vim.api.nvim_set_keymap("n", "]<space>", "o<Esc>k", {noremap = true})

vim.api.nvim_set_keymap("n", "<leader>=", ":resize +5<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>-", ":resize -5<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>+", ":vertical resize +5<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>_", ":vertical resize -5<CR>", {noremap = true})

-- configure plugins
require "config/github-theme"
require "config/hop"
require "config/lsp"
require "config/completion-and-snippets"
require "config/formatter"
require "config/treesitter"
require "config/harpoon"
require "config/gitsigns"
-- require "config/lua-dev"
-- not ready to use telescope yet... seems a bit clunky compared to fzf
-- require "config/telescope"

-- fzf
local brew_root = string.gsub(vim.fn.system("brew --prefix"), "%s", "")
vim.cmd ("set rtp+="..brew_root.."/opt/fzf")
vim.cmd "let g:fzf_layout = {'up': '~50%'}"
-- Find a file
vim.api.nvim_set_keymap("n", "<leader>o", ":Files<CR>", {noremap = true, silent = true})
-- Find an open buffer
vim.api.nvim_set_keymap("n", "<leader>p", ":Buffers<CR>", {noremap = true, silent = true})
vim.g.fzf_buffers_jump = 1

-- grepper
vim.cmd "runtime plugin/grepper.vim"
vim.cmd "let g:grepper.prompt_quote = 0"
vim.cmd "let g:grepper.tools = ['rg']"
vim.api.nvim_set_keymap("n", "<leader>g", ":Grepper<CR>", {noremap = true, silent = true})

-- lsp
vim.cmd "augroup lsp"
vim.cmd "  au!"
vim.cmd "  au FileType java lua print('hello'); require('config/lsp').start_jdt()"
vim.cmd "augroup end"

-- shortcut to quickly toggle Treesitter highlighting, useful when it's slowing down
-- editing on large files
vim.cmd "command! ToggleTSHighlight TSBufToggle highlight"

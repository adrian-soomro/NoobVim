vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local set = vim.opt

set.number = true
set.relativenumber = true
set.tabstop = 2
set.softtabstop = 2
set.expandtab = true
set.shiftwidth = 2
set.smarttab = true
set.wildmode = longest,list
set.clipboard = 'unnamedplus'
set.ttyfast = true
set.mouse = 'a'
set.encoding = 'UTF-8'
set.smartcase = true
set.completeopt = menu,menuone,noselect
set.updatetime = 2000

local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

-- telescope
keymap('n', '<C-p>', [[<Cmd> lua require('telescope.builtin').find_files({ hidden = true })<CR>]], opts)
keymap('n', '<C-f>', [[<Cmd> lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opts)
keymap('n', '<C-F>', [[<Cmd> lua require('telescope.builtin').live_grep()<CR>]], opts)

-- nvim-tree 
keymap('n', '<C-b>', ':NvimTreeToggle <CR>', opts)

-- window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-l>', '<C-w>l', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)

-- can't teach an old dog new tricks section
keymap('n', '<C-s>', [[<Cmd> :w <CR>]], opts)
keymap('i', '<C-s>', [[<Cmd> :w <CR>]], opts)
keymap('v', '<C-s>', [[<Cmd> :w <CR>]], opts)

keymap('n', '<C-w>', [[<Cmd> :q <CR>]], opts)
keymap('i', '<C-w>', [[<Cmd> :q <CR>]], opts)
keymap('v', '<C-w>', [[<Cmd> :q <CR>]], opts)

keymap('n', '<C-V>', [[<Cmd> :Telescope neoclip <CR>]], opts)
keymap('v', '<C-V>', [[<Cmd> :Telescope neoclip <CR>]], opts)
keymap('i', '<C-V>', [[<Cmd> :Telescope neoclip <CR>]], opts)

-- markdown preview toggle
keymap('n', '<A-p>', [[<Cmd> :Glow % <CR>]], opts)
keymap('i', '<A-p>', [[<Cmd> :Glow % <CR>]], opts)
keymap('v', '<A-p>', [[<Cmd> :Glow % <CR>]], opts)

-- smart delete
local function delete_special()
    local line_data = vim.api.nvim_win_get_cursor(0) -- returns {row, col}
    local current_line = vim.api.nvim_buf_get_lines(0, line_data[1]-1, line_data[1], false)
    if current_line[1] == "" then
        return '"_dd'
    else
        return 'dd'
    end
end
vim.keymap.set("n", "dd", delete_special, { noremap = true, expr = true } )

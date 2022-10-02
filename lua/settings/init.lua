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
set.timeoutlen = 300

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

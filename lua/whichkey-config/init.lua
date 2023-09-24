local wk = require('which-key')
local telescope_api = require('telescope.builtin')
local gs = require('gitsigns')
local utils = require('lua-utils')

wk.setup({
  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false,   -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false,     -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <c-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true,            -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    ["<space>"] = "SPACE",
    ["<cr>"] = "RETURN",
    ["<CR>"] = "RETURN",
    ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+ ", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>',   -- binding to scroll up inside the popup
  },
  window = {
    border = "double",        -- none, single, double, shadow
    position = "bottom",      -- bottom, top
    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = { min = 4, max = 25 },                                                     -- min and max height of the columns
    width = { min = 20, max = 50 },                                                     -- min and max width of the columns
    spacing = 3,                                                                        -- spacing between columns
    align = "left",                                                                     -- align columns left, center or right
  },
  ignore_missing = false,                                                               -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<cr>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true,                                                                     -- show help message on the command line when the popup is visible
  triggers = "auto",                                                                    -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
})

local leader_mapping = {
  h = {
    name = "Hunk stuff (Git)",
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage hunk" },
    S = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage buffer" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset buffer" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo stage hunk" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview hunk" },
    d = { "<cmd>lua require 'gitsigns'.diffthis()<cr>", "View diff of this file" },
    D = { "<cmd>DiffviewOpen<cr>", "Diff of the repo" },
  },
  g = {
    name = "Go to",
    d = { "<cmd>Lspsaga peek_definition<cr>", "Peek definition" },
    i = { "<cmd>Lspsaga finder<cr>", "Check out the implementations" },
    s = { "<cmd>Lspsaga hover_doc<cr>", "Check out the signature" },
  },
  c = {
    name = "Code",
    a = { "<cmd>Lspsaga code_action<cr>", "Open code actions" }
  },
  s = {
    name = "Show",
    d = { "<cmd>Lspsaga show_line_diagnostics | Lspsaga show_cursor_diagnostics<cr>", "Show line & cursor diagnostics" },
  },
  i = {
    name = "Insert",
    b = { "<cmd>lua require 'dap'.toggle_breakpoint()<cr>", "Insert breakpoint" },
  },
  f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format file" },
  o = {
    name = "Open",
    o = { "<cmd>Lspsaga outline<cr>", "Toggle lspsaga outline" },
  },
  ['<F5>'] = {
    "<cmd>lua require 'dap'.continue()<cr>", "Continue / Start debug session"
  },
}

local mapping = {
  R = { "<cmd>Lspsaga rename<cr>", "Rename all occurences" },
  ["["] = {
    ["["] = {
      function()
        if vim.wo.diff then return '[[' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, "Jump to previous hunk"
    },
    d = { function()
      require("lspsaga.diagnostic"):goto_prev()
    end, "Jump to previous diagnostic" }
  },
  ["]"] = {
    ["]"] = {
      function()
        if vim.wo.diff then return ']]' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, "Jump to next hunk"
    },
    d = { function()
      require("lspsaga.diagnostic"):goto_next()
    end, "Jump to next diagnostic" }
  },
  ['<F5>'] = { "<cmd>RunCode<cr>", "Run project (see CRProjects) or a file if outside a project" },
  ['<F8>'] = { "<cmd>lua require 'dap'.step_over()<cr>", "Step over (debug)" },
  ['<F9>'] = { "<cmd>lua require 'dap'.step_into()<cr>", "Step into (debug)" },
  ['<F10>'] = { "<cmd>lua require 'dap'.step_out()<cr>", "Step out (debug)" },
  ['<esc>'] = { "<cmd>tabclose<cr>", "Close current tab (window)" },
  ['<C-p>'] = {
    function()
      telescope_api.find_files({ hidden = true })
    end, "Find files"
  },
  ['<C-f>'] = {
    function()
      telescope_api.current_buffer_fuzzy_find()
    end, "Search in current buffer"
  },
  ['<C-S-f>'] = {
    function()
      telescope_api.live_grep()
    end, "Search in current directory"
  },
  ['<C-h>'] = { "<C-w>h", "Switch to buffer left of current buffer" },
  ['<C-k>'] = { "<C-w>k", "Switch to buffer above current buffer" },
  ['<C-j>'] = { "<C-w>j", "Switch to buffer below current buffer" },
  ['<C-l>'] = { "<C-w>l", "Switch to buffer right of current buffer" },
  ['<C-,>'] = { "<cmd>BufferPrevious<cr>", "Previous buffer" },
  ['<C-.>'] = { "<cmd>BufferNext<cr>", "Next buffer" },
  ['<C-S-w>'] = { "<cmd>BufferCloseAllButCurrent<cr>", "Close other buffers" },
  ['<A-b>'] = { "<cmd>NvimTreeToggle<cr>", "Open nvim-tree (file explorer)" },
  ['<A-1>'] = { "<cmd>BufferGoto 1<cr>", "Go 'tab' number 1" },
  ['<A-2>'] = { "<cmd>BufferGoto 2<cr>", "Go 'tab' number 2" },
  ['<A-3>'] = { "<cmd>BufferGoto 3<cr>", "Go 'tab' number 3" },
  ['<A-4>'] = { "<cmd>BufferGoto 4<cr>", "Go 'tab' number 4" },
  ['<A-5>'] = { "<cmd>BufferGoto 5<cr>", "Go 'tab' number 5" },
  ['<A-6>'] = { "<cmd>BufferGoto 6<cr>", "Go 'tab' number 6" },
  ['<A-7>'] = { "<cmd>BufferGoto 7<cr>", "Go 'tab' number 7" },
  ['<A-8>'] = { "<cmd>BufferGoto 8<cr>", "Go 'tab' number 8" },
  ['<A-9>'] = { "<cmd>BufferGoto 9<cr>", "Go 'tab' number 9" },
  ['<A-0>'] = { "<cmd>BufferGoto 0<cr>", "Go 'tab' number 0" },
  ['<A-;>'] = { "<cmd>1ToggleTerm<cr>", "Open first terminal" },
  ["<A-'>"] = { "<cmd>2ToggleTerm<cr>", "Open second terminal" },
}

local insert_mapping = {}

local visual_leader_mapping = {
  c = {
    name = "Code",
    a = { "<esc><cmd>Lspsaga range_code_action<cr>", "Open code actions" }
  },
}

local visual_mapping = {}

local mapping_for_all_modes = {
  ['<C-s>'] = { "<Cmd> :w<cr>", "Save buffer" },
  ['<C-w>'] = { "<Cmd> :BufferClose<cr>", "Close buffer" },
  ['<C-S-v>'] = { "<Cmd> :Telescope neoclip<cr>", "View clipboard history" },
  ['<A-p>'] = { "<Cmd> :Glow %<cr>", "Preview markdown file" },
}

-- normal mode
wk.register(leader_mapping, { prefix = "<leader>" })
wk.register(utils.merge(mapping, mapping_for_all_modes))

-- insert mode
wk.register(utils.merge(insert_mapping, mapping_for_all_modes), { mode = "i" })

-- visual mode
wk.register(utils.merge(visual_mapping, mapping_for_all_modes), { mode = "v" })
wk.register(visual_leader_mapping, { mode = "v", prefix = "<leader>" })

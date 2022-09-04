local wk = require('which-key')
wk.setup({
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
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
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = "double", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
})

local leaderOpts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local visualLeaderOpts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local leaderMapping = {
  h = {
    name = "Hunk stuff (Git)",
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage hunk" },
    S = { "<cmd>lua require 'gitsigns'.stage_buffer()<CR>", "Stage buffer" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset buffer" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", "Undo stage hunk" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview hunk" },
    d = { "<cmd>lua require 'gitsigns'.diffthis()<CR>", "View diff of this file" },
  },
  g = {
    name = "Go to",
    d = { "<cmd>Lspsaga preview_definition<cr>", "Preview definition" },
    i = { "<cmd>Lspsaga lsp_finder<cr>", "Check out the implementations" },
    s = { "<cmd>Lspsaga signature_help<cr>", "Check out the signature" },
  },
  c = {
    a = { "<cmd>Lspsaga code_action<cr>", "Open code actions" }
  },
  s = {
    name = "Show",
    d = { "<cmd>Lspsaga show_line_diagnostics | Lspsaga show_cursor_diagnostics<cr>", "Show line & cursor diagnostics" },
  },
  f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format file" },
  o = { "<cmd>LSoutlineToggle<CR>", "Toggle lspsaga outline" },
  ['<F5>'] = {
    "<cmd>RunFile<cr>", "Run current file"
  }
}

local gs = require('gitsigns')

local mapping = {
  R = { "<cmd>Lspsaga rename<cr>", "Rename all occurences" },
  K = { "<cmd>Lspsaga hover_doc<cr>", "Toggle hover doc" },
  ["["] = {
    ["["] = { function()
      if vim.wo.diff then return '[[' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, "Jump to previous hunk" },
    d = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Jump to previous diagnostic" }
  },
  ["]"] = {
    ["]"] = { function()
      if vim.wo.diff then return ']]' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, "Jump to next hunk" },
    d = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Jump to next diagnostic" }
  },
  ['<F5>'] = {
    "<cmd>RunCode<cr>", "Run project (see CRProjects) or a file if outside a project"
  }
}

local visualLeaderMapping = {
  c = {
    a = { "<esc><cmd>Lspsaga range_code_action<cr>", "Open code actions" }
  },
}

wk.register(leaderMapping, leaderOpts)
wk.register(mapping, opts)

wk.register(visualLeaderMapping, visualLeaderOpts)
